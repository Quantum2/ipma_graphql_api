//
//  File.swift
//  
//
//  Created by Rafael Francisco on 28/09/2020.
//

import Foundation
import Vapor

final class WeatherProcesser {
    let logger = Logger(label: "com.ipma_api.WeatherProcesser")
    
    let client: Client
    var timer: DispatchSourceTimer?
    
    var locations = [Location]()
    var forecasts = [Location:[ForecastElement]]()
    
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
        
        timer!.schedule(deadline: .now(), repeating: .seconds(600))
        timer!.setEventHandler { [weak self] in
            self?.logger.info("Updating weather info")
            self?.startUpdatingForecastForLocations()
        }
        timer!.resume()
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func startUpdatingForecastForLocations() {
        self.client.get("http://api.ipma.pt/public-data/forecast/locations.json").flatMapThrowing { res in
            try res.content.decode([Location].self)
        }.map { json in
            self.locations = json
        }.whenSuccess { _ in
            self.locations.forEach { location in
                self.client.get("https://api.ipma.pt/public-data/forecast/aggregate/\(location.globalIDLocal).json").flatMapThrowing { res in
                    try res.content.decode([ForecastElement].self)
                }.map { elements in
                    self.forecasts[location] = elements
                }
            }
        }
    }
}
