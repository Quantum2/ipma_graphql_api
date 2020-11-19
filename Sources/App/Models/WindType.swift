//
//  File.swift
//  
//
//  Created by Rafael Francisco on 19/11/2020.
//

import Foundation
import GraphQLKit

// MARK: - WindType
struct WindType: Codable {
    let owner, country: String
    let data: [WindTypeData]
}

// MARK: - WindTypeData
struct WindTypeData: Codable {
    let descClassWindSpeedDailyEN, descClassWindSpeedDailyPT, classWindSpeed: String
}

extension WindType: FieldKeyProvider {
    typealias FieldKey = FieldKeys

    enum FieldKeys: String {
        case owner, country
        case data
    }
}

extension WindTypeData: FieldKeyProvider {
    typealias FieldKey = FieldKeys

    enum FieldKeys: String {
        case descIDWeatherTypeEN = "descIdWeatherTypeEN"
        case descIDWeatherTypePT = "descIdWeatherTypePT"
        case classWindSpeed
    }
}
