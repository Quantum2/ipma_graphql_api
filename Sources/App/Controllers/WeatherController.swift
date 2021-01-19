//
//  File.swift
//  
//
//  Created by Rafael Francisco on 28/09/2020.
//

import Foundation
import Vapor
import GraphQLKit

final class WeatherController {
    let logger = Logger(label: "com.ipma_api.WeatherController")
    
    let weatherProcesser: WeatherProcesser
    let weatherTypeProcesser: WeatherTypesProcesser
    let weatherStationsProcesser: WeatherStationsProcesser
    
    let dateFormatter = DateFormatter()
    
    init(_ weatherProcesser: WeatherProcesser, _ typesProcesser: WeatherTypesProcesser, _ stationsProcesser: WeatherStationsProcesser) {
        self.weatherProcesser = weatherProcesser
        self.weatherTypeProcesser = typesProcesser
        self.weatherStationsProcesser = stationsProcesser
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }
    
    func fetchLocations(request: Request, _: NoArguments) throws -> [Location] {
        return weatherProcesser.locations
    }
    
    func fetchDayForecast(request: Request, arguments: ForecastArguments) throws -> ForecastElement? {
        return self.getDayForecast(arguments)
    }
    
    func fetchCurrentForecast(request: Request, arguments: ForecastArguments) throws -> ForecastElement? {
        return self.getCurrentForecast(arguments)
    }
    
    func fetchNext24HoursForecast(request: Request, arguments: ForecastArguments) throws -> [ForecastElement]? {
        return self.getNext24HoursForecast(arguments)
    }
    
    func fetchTenDaysForecast(request: Request, arguments: ForecastArguments) throws -> [ForecastElement]? {
        return self.getTenDaysForecast(arguments)
    }
    
    func fetchClosestLocation(request: Request, arguments: PositionArguments) throws -> Location {
        return self.getClosestLocation(arguments)
    }
    
    func fetchWeatherTypeForId(request: Request, arguments: WeatherTypeArguments) throws -> WeatherTypeData? {
        return weatherTypeProcesser.weatherTypes.first(where: { $0.idWeatherType == arguments.weatherId })
    }
    
    func fetchWeatherTypes(request: Request, _: NoArguments) throws -> [WeatherTypeData] {
        return weatherTypeProcesser.weatherTypes
    }
    
    func fetchWindTypes(request: Request, _: NoArguments) throws -> [WindTypeData] {
        return weatherTypeProcesser.windTypes
    }
    func fetchRainTypes(request: Request, _: NoArguments) throws -> [RainTypeData] {
        return weatherTypeProcesser.rainTypes
    }
    
    func fetchStationsInfo(request: Request, _: NoArguments) throws -> [StationObservation] {
        return weatherStationsProcesser.stationsObservations
    }
    
    func fetchImageForWeatherType(request: Request, arguments: WeatherTypeArguments) throws -> WeatherImage? {
        let staticUrl = "https://www.ipma.pt/bin/icons/svg/weather/w_ic_d_\(String(format: "%02d", arguments.weatherId)).svg"
        let animatedUrl = "https://www.ipma.pt/bin/icons/svg/weather/w_ic_d_\(String(format: "%02d", arguments.weatherId))anim.svg"
        let nightUrl = "https://www.ipma.pt/bin/icons/svg/weather/w_ic_n_\(String(format: "%02d", arguments.weatherId)).svg"
        
        return WeatherImage(staticUrl: staticUrl, animatedUrl: animatedUrl, nightUrl: nightUrl)
    }
    
    //MARK: NonResponseMethods
    
    func refreshData() {
        self.weatherProcesser.stopTimer()
        self.weatherProcesser.startTimer()
        
        self.weatherTypeProcesser.getWeatherTypes()
        self.logger.info("Weather data updated")
    }
    
    //MARK: InternalMethods
    
    private func getClosestLocation(_ args: PositionArguments) -> Location {
        var minDistance: CGFloat = .greatestFiniteMagnitude
        var minLocation: Location?
        
        let posA = CGPoint(x: args.latitude, y: args.longitude)
        
        self.weatherProcesser.locations.forEach { location in
            let posB = CGPoint(x: Double(location.latitude)!, y: Double(location.longitude)!)
            let tempDistance = distance(posA, posB)
            
            if tempDistance < minDistance {
                minDistance = tempDistance
                minLocation = location
            }
        }
        
        return minLocation!
    }
    
    private func getDayForecast(_ args: ForecastArguments) -> ForecastElement? {
        guard let placeArray = weatherProcesser.locations.filter({ $0.globalIDLocal == args.globalId }).first else { return nil }
        guard let placeForecasts = weatherProcesser.forecasts[placeArray] else { return nil }
        
        return placeForecasts.first(where: { $0.idPeriodo == 24 })
    }
    
    private func getCurrentForecast(_ args: ForecastArguments) -> ForecastElement? {
        guard let placeArray = weatherProcesser.locations.filter({ $0.globalIDLocal == args.globalId }).first else { return nil }
        guard let placeForecasts = weatherProcesser.forecasts[placeArray] else { return nil }
        
        let date = Date()
        
        return placeForecasts.filter{ $0.idPeriodo == 1 }.enumerated().min(by: { abs(date-self.dateFormatter.date(from: $0.1.dataPrev)!) < abs(date-self.dateFormatter.date(from: $1.1.dataPrev)!) })!.element
    }
    
    private func getNext24HoursForecast(_ args: ForecastArguments) -> [ForecastElement]? {
        guard let placeArray = weatherProcesser.locations.filter({ $0.globalIDLocal == args.globalId }).first else { return nil }
        guard let placeForecasts = weatherProcesser.forecasts[placeArray] else { return nil }
        
        let date = Date()
        let finalArray = placeForecasts.filter{ $0.idPeriodo == 1 && self.dateFormatter.date(from: $0.dataPrev)! - date > 0 }
        
        if finalArray.count >= 24 {
            return Array(finalArray[0 ... 24])
        } else {
            return nil
        }
    }
    
    private func getTenDaysForecast(_ args: ForecastArguments) -> [ForecastElement]? {
        guard let placeArray = weatherProcesser.locations.filter({ $0.globalIDLocal == args.globalId }).first else { return nil }
        guard let placeForecasts = weatherProcesser.forecasts[placeArray] else { return nil }
        
        return placeForecasts.filter{ $0.idPeriodo == 24 }
    }
}
