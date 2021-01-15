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
