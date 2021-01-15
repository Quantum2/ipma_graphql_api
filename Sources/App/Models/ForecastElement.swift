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
    let intervaloHora: String?
    let idTipoTempo, globalIDLocal: Int
    let probabilidadePrecipita: String
    let idPeriodo: Int
    let dataPrev: String
    let ddVento: String
    let tMed, hR, utci, ffVento: String?
    let idIntensidadePrecipita: Int?
    let tempAguaMar, periodoPico, ondulacao: String?
    let dirOndulacao: String?
    let marTotal, periodOndulacao: String?

    enum CodingKeys: String, CodingKey {
        case tMin, idFfxVento, dataUpdate, tMax, iUv, intervaloHora, idTipoTempo
        case globalIDLocal = "globalIdLocal"
        case probabilidadePrecipita, idPeriodo, dataPrev, ddVento, tMed, hR, utci, ffVento, idIntensidadePrecipita, tempAguaMar, periodoPico, ondulacao, dirOndulacao, marTotal, periodOndulacao
    }
}
