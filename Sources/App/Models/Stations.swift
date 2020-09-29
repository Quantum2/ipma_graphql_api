//
//  Stations.swift
//  
//
//  Created by Rafael Francisco on 29/09/2020.
//

import Foundation
import GraphQLKit

// MARK: - StationObservationClass
struct StationObservationClass: Codable {
    let intensidadeVentoKM, temperatura, radiacao: Double
    let idDireccVento: Int
    let precAcumulada, intensidadeVento: Double
    let humidade: Int
    let pressao: Double
}

// MARK: - Station
struct Station: Codable {
    let geometry: Geometry
    let type: StationType
    let properties: Properties
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [Double]
}

enum GeometryType: String, Codable {
    case point = "Point"
}

// MARK: - Properties
struct Properties: Codable {
    let idEstacao: Int
    let localEstacao: String
}

enum StationType: String, Codable {
    case feature = "Feature"
}

typealias StationObservationResponse = [String: [String: StationObservationClass?]]
typealias Stations = [Station]

struct StationObservation: Codable {
    let date: String
    let id: Int
    let observation: StationObservationClass
}

extension StationObservation: FieldKeyProvider {
    typealias FieldKey = FieldKeys

    enum FieldKeys: String {
        case date, id
        case observation
    }
}
