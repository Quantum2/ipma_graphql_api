//
//  File.swift
//  
//
//  Created by Rafael Francisco on 28/09/2020.
//

import Foundation

struct ForecastArguments: Codable {
    let globalId: Int
}

struct PositionArguments: Codable {
    let latitude, longitude: Double
}

struct WeatherTypeArguments: Codable {
    let weatherId: Int
}
