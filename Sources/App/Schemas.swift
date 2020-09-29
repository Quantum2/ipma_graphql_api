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
            Field(.tMin, at: \.tMin),
            Field(.idFfxVento, at: \.idFfxVento),
            Field(.dataUpdate, at: \.dataUpdate),
            Field(.tMax, at: \.tMax),
            Field(.iUv, at: \.iUv),
            Field(.intervaloHora, at: \.intervaloHora),
            Field(.globalIDLocal, at : \.globalIDLocal),
            Field(.probabilidadePrecipita, at: \.probabilidadePrecipita),
            Field(.idPeriodo, at: \.idPeriodo),
            Field(.dataPrev, at: \.dataPrev),
            Field(.ddVento, at: \.ddVento),
            Field(.tMed, at: \.tMed),
            Field(.hR, at: \.hR),
            Field(.utci, at: \.utci),
            Field(.ffVento, at: \.ffVento),
            Field(.idIntensidadePrecipita, at: \.idIntensidadePrecipita),
            Field(.tempAguaMar, at: \.tempAguaMar),
            Field(.periodoPico, at: \.periodoPico),
            Field(.ondulacao, at: \.ondulacao),
            Field(.dirOndulacao, at: \.dirOndulacao),
            Field(.marTotal, at: \.marTotal),
            Field(.periodOndulacao, at: \.periodOndulacao)
        ]),
        
        Type(WeatherTypeData.self, fields: [
            Field(.descIDWeatherTypeEN, at: \.descIDWeatherTypeEN),
            Field(.descIDWeatherTypePT, at: \.descIDWeatherTypePT),
            Field(.idWeatherType, at: \.idWeatherType)
        ]),
        
        Query([
            Field(.fetchLocations, at: WeatherController.fetchLocations),
            
            Field(.fetchForecast, at: WeatherController.fetchForecast)
                .argument(.locationID, at: \.globalId),
            
            Field(.fetchClosestLocation, at: WeatherController.fetchClosestLocation)
                .argument(.positionLatitude, at: \.latitude)
                .argument(.positionLongitude, at: \.longitude),
            
            Field(.fetchWeatherTypes, at: WeatherController.fetchWeatherTypes)
        ]),
        
        Types(ForecastElement.self, Location.self, WeatherTypeData.self)
    ])
}
