import Vapor
import GraphiQLVapor

func routes(_ app: Application) throws {
    let weatherProcesser = WeatherProcesser(app)
    let weatherTypesProcesser = WeatherTypesProcesser(app)
    
    let weatherController = WeatherController(weatherProcesser: weatherProcesser, typesProcesser: weatherTypesProcesser)
    
    app.register(graphQLSchema: Schemas.schema, withResolver: weatherController)
    app.enableGraphiQL()
}
