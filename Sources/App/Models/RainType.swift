//
//  File.swift
//  
//
//  Created by Rafael Francisco on 19/11/2020.
//

import Foundation
import GraphQLKit

// MARK: - RainType
struct RainType: Codable {
    let owner, country: String
    let data: [RainTypeData]
}

// MARK: - RainTypeData
struct RainTypeData: Codable {
    let descClassPrecIntEN, descClassPrecIntPT, classPrecInt: String
}

extension RainType: FieldKeyProvider {
    typealias FieldKey = FieldKeys

    enum FieldKeys: String {
        case owner, country
        case data
    }
}

extension RainTypeData: FieldKeyProvider {
    typealias FieldKey = FieldKeys

    enum FieldKeys: String {
        case descIDWeatherTypeEN = "descIdWeatherTypeEN"
        case descIDWeatherTypePT = "descIdWeatherTypePT"
        case classPrecInt
    }
}
