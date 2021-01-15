//
//  File.swift
//  
//
//  Created by Rafael Francisco on 28/09/2020.
//

import Foundation
import GraphQLKit
import Vapor

// MARK: - Location
struct Location: Codable, Hashable {
    let idRegiao: Int
    let idAreaAviso: String
    let globalIDLocal, idConcelho: Int
    let latitude: String
    let idDistrito: Int
    let local, longitude: String

    enum CodingKeys: String, CodingKey {
        case idRegiao, idAreaAviso
        case globalIDLocal = "globalIdLocal"
        case idConcelho, latitude, idDistrito, local, longitude
    }
}
