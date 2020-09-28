// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecast = try? newJSONDecoder().decode(Forecast.self, from: jsonData)

import Foundation
import GraphQLKit

// MARK: - ForecastElement
struct ForecastElement: Codable {
    let tMin: String?
    let idFfxVento: Int?
    let dataUpdate: String
    let tMax, iUv: String?
    let intervaloHora: IntervaloHora?
    let idTipoTempo, globalIDLocal: Int
    let probabilidadePrecipita: String
    let idPeriodo: Int
    let dataPrev: String
    let ddVento: DDVento
    let tMed, hR, utci, ffVento: String?
    let idIntensidadePrecipita: Int?
    let tempAguaMar, periodoPico, ondulacao: String?
    let dirOndulacao: DDVento?
    let marTotal, periodOndulacao: String?

    enum CodingKeys: String, CodingKey {
        case tMin, idFfxVento, dataUpdate, tMax, iUv, intervaloHora, idTipoTempo
        case globalIDLocal = "globalIdLocal"
        case probabilidadePrecipita, idPeriodo, dataPrev, ddVento, tMed, hR, utci, ffVento, idIntensidadePrecipita, tempAguaMar, periodoPico, ondulacao, dirOndulacao, marTotal, periodOndulacao
    }
}

enum DDVento: String, Codable {
    case e = "E"
    case n = "N"
    case ne = "NE"
    case nw = "NW"
    case s = "S"
    case se = "SE"
    case sw = "SW"
    case w = "W"
}

enum IntervaloHora: String, Codable {
    case the13H13H = "13h-13h"
    case the14H14H = "14h-14h"
}

struct Forecast: Codable {
    let forecasts: [ForecastElement]
}

struct ForecastArguments : Codable {
    let location: Location?
}

extension Forecast: FieldKeyProvider {
    typealias FieldKey = FieldKeys

    enum FieldKeys: String {
        case forecasts
    }
}
