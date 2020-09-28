//
//  File.swift
//  
//
//  Created by Rafael Francisco on 28/09/2020.
//

import Foundation
import Vapor
import GraphQLKit

enum Schemas {
    static var locationsSchema = Schema<WeatherController, Request>([
        Type(Location.self, fields: [
            Field(.local, at: \.local),
            Field(.idRegiao, at: \.idRegiao),
        ]),
        Query([
            Field(.fetchLocations, at: WeatherController.fetchLocations),
        ]),
    ])
    
    static var forecastSchema = Schema<WeatherController, Request>([
        Type(Forecast.self, fields: [
            Field(.forecasts, at: \.forecasts)
        ]),
        Query([
            Field(.fetchForecast, at: WeatherController.fetchForecast)
                .argument(.location, at: \.location)
        ]),
    ])
}
