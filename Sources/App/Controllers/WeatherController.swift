//
//  File.swift
//  
//
//  Created by Rafael Francisco on 28/09/2020.
//

import Foundation
import Vapor
import GraphQLKit

final class WeatherController {
    let weatherProcesser: WeatherProcesser
    
    init(processer: WeatherProcesser) {
        self.weatherProcesser = processer
    }
    
    func fetchLocations(request: Request, _: NoArguments) throws -> [Location] {
        return weatherProcesser.locations
    }
}
