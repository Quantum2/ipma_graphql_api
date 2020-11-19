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
            Field(.idTipoTempo, at : \.idTipoTempo),
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
        
        Type(WindTypeData.self, fields: [
            Field(.descIDWeatherTypeEN, at: \.descIDWeatherTypeEN),
            Field(.descIDWeatherTypePT, at: \.descIDWeatherTypePT),
            Field(.idWeatherType, at: \.classWindSpeed)
        ]),
        
        Type(RainTypeData.self, fields: [
            Field(.descIDWeatherTypeEN, at: \.descIDWeatherTypeEN),
            Field(.descIDWeatherTypePT, at: \.descIDWeatherTypePT),
            Field(.idWeatherType, at: \.classPrecInt)
        ]),
        
        Type(StationObservationClass.self, fields: [
            Field(.intensidadeVentoKM, at: \.intensidadeVentoKM),
            Field(.temperatura, at: \.temperatura),
            Field(.radiacao, at: \.radiacao),
            Field(.idDireccVento, at: \.idDireccVento),
            Field(.precAcumulada, at: \.precAcumulada),
            Field(.intensidadeVento, at: \.intensidadeVento),
            Field(.humidade, at: \.humidade),
            Field(.pressao, at: \.pressao)
        ]),
        
        Type(StationObservation.self, fields: [
            Field(.date, at: \.date),
            Field(.id, at: \.id),
            Field(.observation, at: \.observation),
            Field(.latitude, at: \.latitude),
            Field(.longitude, at: \.longitude),
            Field(.local, at: \.local)
        ]),
        
        Query([
            Field(.fetchLocations, at: WeatherController.fetchLocations),
            
            Field(.fetchForecast, at: WeatherController.fetchForecast)
                .argument(.locationID, at: \.globalId),
            
            Field(.fetchClosestLocation, at: WeatherController.fetchClosestLocation)
                .argument(.positionLatitude, at: \.latitude)
                .argument(.positionLongitude, at: \.longitude),
            
            Field(.fetchWeatherTypes, at: WeatherController.fetchWeatherTypes),
            
            Field(.fetchStationsInfo, at: WeatherController.fetchStationsInfo)
        ]),
        
        Types(ForecastElement.self, Location.self, WeatherTypeData.self, WindTypeData.self, RainTypeData.self, StationObservationClass.self, StationObservation.self)
    ])
}
