//
//  File.swift
//  
//
//  Created by Rafael Francisco on 29/09/2020.
//

import Foundation
import Vapor

final class WeatherTypesProcesser {
    let logger = Logger(label: "com.ipma_api.WeatherTypes")
    let client: Client
    
    var weatherTypes = [WeatherTypeData]()

    init(_ app: Application) {
        self.client = app.client
        self.getWeatherTypes()
    }
    
    private func getWeatherTypes() {
        client.get("https://api.ipma.pt/open-data/weather-type-classe.json").flatMapThrowing { res in
            try res.content.decode(WeatherType.self)
        }.map { json in
            self.weatherTypes = json.data
        }
    }
}
