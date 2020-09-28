//
//  File.swift
//  
//
//  Created by Rafael Francisco on 28/09/2020.
//

import Foundation
import Vapor
import GraphQLKit

enum Schemas {
    static var schema = Schema<WeatherController, Request>([
        Type(Location.self, fields: [
            Field(.local, at: \.local),
            Field(.idRegiao, at: \.idRegiao),
            Field(.idAreaAviso, at: \.idAreaAviso),
            Field(.latitude, at: \.latitude),
            Field(.longitude, at: \.longitude),
            Field(.globalIDLocal, at: \.globalIDLocal)
        ]),
        
        Type(ForecastElement.self, fields: [
            /*
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
             */
            Field(.tMin, at: \.tMin),
            Field(.idFfxVento, at: \.idFfxVento),
            Field(.dataUpdate, at: \.dataUpdate),
            Field(.tMax, at: \.tMax),
            Field(.iUv, at: \.iUv),
            Field(.intervaloHora, at: \.intervaloHora),
            Field(.globalIDLocal, at : \.globalIDLocal),
            Field(.probabilidadePrecipita, at: \.probabilidadePrecipita),
            Field(.idPeriodo, at: \.idPeriodo)
        ]),
        
        Query([
            Field(.fetchLocations, at: WeatherController.fetchLocations),
            Field(.fetchForecast, at: WeatherController.fetchForecast)
                .argument(.locationID, at: \.globalId)
        ]),
        
        Types(ForecastElement.self, Location.self),
    ])
}
