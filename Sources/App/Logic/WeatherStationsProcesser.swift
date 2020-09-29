//
//  File.swift
//  
//
//  Created by Rafael Francisco on 29/09/2020.
//

import Foundation
import Vapor

final class WeatherStationsProcesser {
    let logger = Logger(label: "com.ipma_api.WeatherStationsProcesser")
    
    let client: Client
    var timer: DispatchSourceTimer?
    
    var stationsFinal = [StationObservation]()
    private var stations = Stations()
    
    init(_ app: Application) {
        self.client = app.client
        self.startTimer()
    }
    
    deinit {
        self.stopTimer()
    }
    
    func startTimer() {
        let queue = DispatchQueue(label: "com.ipma_api.app.timer")  // you can also use `DispatchQueue.main`, if you want
        timer = DispatchSource.makeTimerSource(queue: queue)
        
        timer!.schedule(deadline: .now(), repeating: .seconds(43200))
        timer!.setEventHandler { [weak self] in
            self?.logger.info("Updating stations info")
            self?.startUpdatingStations()
        }
        timer!.resume()
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func startUpdatingStations() {
        client.get("https://api.ipma.pt/open-data/observation/meteorology/stations/stations.json").flatMapThrowing { res in
            try res.content.decode(Stations.self)
        }.map { json in
            self.stations = json
        }.whenSuccess { [unowned self] _ in
            client.get("https://api.ipma.pt/open-data/observation/meteorology/stations/observations.json").flatMapThrowing { res in
                try res.content.decode(StationObservationResponse.self)
            }.map { json in
                var internalJson = json
                
                while internalJson.keys.count > 0 {
                    let latestArrayKey = getDateToString(internalJson.keys.map{getDateFromString($0)}.max()!)
                    let values = internalJson[latestArrayKey]!
                    
                    for obs in values {
                        guard obs.value != nil else { continue }
                        guard !stationsFinal.contains(where: {$0.id == Int(obs.key)!}) else { continue }
                        
                        stationsFinal.append(StationObservation(date: latestArrayKey, id: Int(obs.key)!, observation: obs.value!))
                    }
                    
                    internalJson.removeValue(forKey: latestArrayKey)
                }
                
                logger.info("Stations info updated")
            }
        }
    }
    
    private func getDateFromString(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        return dateFormatter.date(from:string)!
    }
    
    private func getDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        return dateFormatter.string(from: date)
    }
}
