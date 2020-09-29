//
//  File.swift
//  
//
//  Created by Rafael Francisco on 28/09/2020.
//

import Foundation
import GraphQLKit

// MARK: - WeatherType
struct WeatherType: Codable {
    let owner, country: String
    let data: [WeatherTypeData]
}

// MARK: - Datum
struct WeatherTypeData: Codable {
    let descIDWeatherTypeEN, descIDWeatherTypePT: String
    let idWeatherType: Int

    enum CodingKeys: String, CodingKey {
        case descIDWeatherTypeEN = "descIdWeatherTypeEN"
        case descIDWeatherTypePT = "descIdWeatherTypePT"
        case idWeatherType
    }
}

extension WeatherType: FieldKeyProvider {
    typealias FieldKey = FieldKeys

    enum FieldKeys: String {
        case owner, country
        case data
    }
}

extension WeatherTypeData: FieldKeyProvider {
    typealias FieldKey = FieldKeys

    enum FieldKeys: String {
        case descIDWeatherTypeEN = "descIdWeatherTypeEN"
        case descIDWeatherTypePT = "descIdWeatherTypePT"
        case idWeatherType
    }
}
