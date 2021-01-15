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
