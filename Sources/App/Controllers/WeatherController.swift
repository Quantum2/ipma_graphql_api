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
    let weatherProcesser: WeatherProcesser
    
    init(processer: WeatherProcesser) {
        self.weatherProcesser = processer
    }
    
    func fetchLocations(request: Request, _: NoArguments) throws -> [Location] {
        return weatherProcesser.locations
    }
    
    func fetchForecast(request: Request, arguments: ForecastArguments) throws -> Forecast? {
        return weatherProcesser.forecasts[weatherProcesser.locations.filter{ $0.globalIDLocal == arguments.location?.globalIDLocal }[0]]
    }
}

extension WeatherController: FieldKeyProvider {
    typealias FieldKey = FieldKeys

    enum FieldKeys: String {
        case fetchLocations
        case fetchForecast
        case location
    }
}
