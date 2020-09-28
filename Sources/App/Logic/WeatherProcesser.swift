//
//  File.swift
//  
//
//  Created by Rafael Francisco on 28/09/2020.
//

import Foundation
import Vapor

final class WeatherProcesser {
    let client: Client
    
    var locations = [Location]()
    var forecasts = [Location:Forecast]()
    
    init(_ app: Application) {
        self.client = app.client
        self.startUpdatingForecastForLocations()
    }
    
    private func startUpdatingForecastForLocations() {
        client.get("http://api.ipma.pt/public-data/forecast/locations.json").flatMapThrowing { res in
            try res.content.decode([Location].self)
        }.map { json in
            self.locations = json
        }
    }
}
