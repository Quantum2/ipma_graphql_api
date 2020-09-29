//
//  File.swift
//  
//
//  Created by Rafael Francisco on 29/09/2020.
//

import Foundation
import Vapor

struct RefreshCommand: Command {
    struct Signature: CommandSignature { }
    
    var help: String {
        get {
            "Refresh stored weather data immediately instead of waiting for scheduled updates"
        }
    }
    
    let weatherController: WeatherController
    
    func run(using context: CommandContext, signature: Signature) throws {
        context.console.print("Refreshing weather information")
        weatherController.refreshData()
    }
}
