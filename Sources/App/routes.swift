import Vapor
import GraphiQLVapor

func routes(_ app: Application) throws {
    let weatherProcesser = WeatherProcesser(app)
    let weatherTypesProcesser = WeatherTypesProcesser(app)
    let weatherStationsProcesser = WeatherStationsProcesser(app)
    
    let weatherController = WeatherController(weatherProcesser, weatherTypesProcesser, weatherStationsProcesser)
    
    app.register(graphQLSchema: Schemas.schema, withResolver: weatherController)
    app.enableGraphiQL()
    
    app.get("hello") { req in
        return "Hello, world!"
    }
    
    app.commands.use(RefreshCommand(weatherController: weatherController), as: "refresh")
}
