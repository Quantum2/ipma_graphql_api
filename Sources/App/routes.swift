import Vapor
import GraphiQLVapor

func routes(_ app: Application) throws {
    let weatherProcesser = WeatherProcesser(app)
    let weatherTypesProcesser = WeatherTypesProcesser(app)
    let weatherStationsProcesser = WeatherStationsProcesser(app)
    
    do {
        let weatherController = WeatherController(weatherProcesser, weatherTypesProcesser, weatherStationsProcesser)
        let schemaStruct = try Schemas(controller: weatherController)
        
        app.register(graphQLSchema: schemaStruct.schema, withResolver: weatherController)
        app.enableGraphiQL()
        
        app.get("hello") { req in
            return "Hello, world!"
        }
        
        app.commands.use(RefreshCommand(weatherController: weatherController), as: "refresh")
    } catch {
        app.logger.error("\(error.localizedDescription)")
    }
}
