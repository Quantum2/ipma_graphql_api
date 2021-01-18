//
//  File.swift
//  
//
//  Created by Rafael Francisco on 28/09/2020.
//

import Foundation
import Vapor
import GraphQLKit

struct Schemas {
    let controller: WeatherController
    let schema: Schema<WeatherController, Request>
    
    init(controller: WeatherController) throws {
        self.controller = controller
        
        self.schema = try Schema<WeatherController, Request> {
            Type(Location.self) {
                Field("local", at: \.local)
                Field("idRegiao", at: \.idRegiao)
                Field("idAreaAviso", at: \.idAreaAviso)
                Field("latitude", at: \.latitude)
                Field("longitude", at: \.longitude)
                Field("globalIDLocal", at: \.globalIDLocal)
            }
            
            Type(ForecastElement.self) {
                Field("tMin", at: \.tMin)
                Field("idFfxVento", at: \.idFfxVento)
                Field("dataUpdate", at: \.dataUpdate)
                Field("tMax", at: \.tMax)
                Field("iUv", at: \.iUv)
                Field("intervaloHora", at: \.intervaloHora)
                Field("globalIDLocal", at : \.globalIDLocal)
                Field("idTipoTempo", at : \.idTipoTempo)
                Field("probabilidadePrecipita", at: \.probabilidadePrecipita)
                Field("idPeriodo", at: \.idPeriodo)
                Field("dataPrev", at: \.dataPrev)
                Field("ddVento", at: \.ddVento)
                Field("tMed", at: \.tMed)
                Field("hR", at: \.hR)
                Field("utci", at: \.utci)
                Field("ffVento", at: \.ffVento)
                Field("idIntensidadePrecipita", at: \.idIntensidadePrecipita)
                Field("tempAguaMar", at: \.tempAguaMar)
                Field("periodoPico", at: \.periodoPico)
                Field("ondulacao", at: \.ondulacao)
                Field("dirOndulacao", at: \.dirOndulacao)
                Field("marTotal", at: \.marTotal)
                Field("periodOndulacao", at: \.periodOndulacao)
            }
            
            Type(WeatherTypeData.self) {
                Field("descIDWeatherTypeEN", at: \.descIDWeatherTypeEN)
                Field("descIDWeatherTypePT", at: \.descIDWeatherTypePT)
                Field("idWeatherType", at: \.idWeatherType)
            }
            
            Type(WindTypeData.self) {
                Field("descClassWindSpeedDailyEN", at: \.descClassWindSpeedDailyEN)
                Field("descClassWindSpeedDailyPT", at: \.descClassWindSpeedDailyPT)
                Field("classWindSpeed", at: \.classWindSpeed)
            }
            
            Type(RainTypeData.self) {
                Field("descClassPrecIntEN", at: \.descClassPrecIntEN)
                Field("descClassPrecIntPT", at: \.descClassPrecIntPT)
                Field("classPrecInt", at: \.classPrecInt)
            }
            
            Type(StationObservationInformation.self) {
                Field("intensidadeVentoKM", at: \.intensidadeVentoKM)
                Field("temperatura", at: \.temperatura)
                Field("radiacao", at: \.radiacao)
                Field("idDireccVento", at: \.idDireccVento)
                Field("precAcumulada", at: \.precAcumulada)
                Field("intensidadeVento", at: \.intensidadeVento)
                Field("humidade", at: \.humidade)
                Field("pressao", at: \.pressao)
            }
            
            Type(StationObservation.self) {
                Field("date", at: \.date)
                Field("id", at: \.id)
                Field("observation", at: \.observation)
                Field("latitude", at: \.latitude)
                Field("longitude", at: \.longitude)
                Field("local", at: \.local)
            }
            
            Query {
                Field("locations", at: WeatherController.fetchLocations)
                
                Field("forecastDay", at: WeatherController.fetchDayForecast) {
                    Argument("globalId", at: \.globalId)
                }
                
                Field("forecastCurrent", at: WeatherController.fetchCurrentForecast) {
                    Argument("globalId", at: \.globalId)
                }
                
                Field("forecastTenDays", at: WeatherController.fetchTenDaysForecast) {
                    Argument("globalId", at: \.globalId)
                }
                
                Field("closestLocation", at: WeatherController.fetchClosestLocation) {
                    Argument("latitude", at: \.latitude)
                    Argument("longitude", at: \.longitude)
                }
                
                Field("weatherTypes", at: WeatherController.fetchWeatherTypes)
                
                Field("stationsInfo", at: WeatherController.fetchStationsInfo)
            }
        }
    }
}
