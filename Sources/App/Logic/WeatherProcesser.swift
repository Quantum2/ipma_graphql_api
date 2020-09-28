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
    
    init(_ app: Application) {
        self.client = app.client
        self.startUpdatingForecastForLocations()
    }
    
    private func startUpdatingForecastForLocations() {
        
    }
}
