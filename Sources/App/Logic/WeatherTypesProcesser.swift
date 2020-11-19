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
    var windTypes = [WindTypeData]()
    var rainTypes = [RainTypeData]()

    init(_ app: Application) {
        self.client = app.client
        self.getWeatherTypes()
    }
    
    func getWeatherTypes() {
        client.get("https://api.ipma.pt/open-data/weather-type-classe.json").flatMapThrowing { res in
            try res.content.decode(WeatherType.self)
        }.map { json in
            self.weatherTypes = json.data
            logger.info("Updated Weather Types")
        }
    }
    
    func getRainTypes() {
        client.get("https://api.ipma.pt/open-data/precipitation-classe.json").flatMapThrowing{ res in
            try res.content.decode(RainType.self)
        }.map { json in
            self.rainTypes = json.data
            logger.info("Updated Rain Types")
        }
    }
    
    func getWindTypes() {
        client.get("https://api.ipma.pt/open-data/wind-speed-daily-classe.json").flatMapThrowing{ res in
            try res.content.decode(WindType.self)
        }.map { json in
            self.windTypes = json.data
            logger.info("Updated Wind Types")
        }
    }
}
