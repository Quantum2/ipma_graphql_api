import Vapor
import GraphiQLVapor

func routes(_ app: Application) throws {
    let weatherProcesser = WeatherProcesser(app)
    let weatherController = WeatherController(processer: weatherProcesser)
    
    app.register(graphQLSchema: Schemas.schema, withResolver: weatherController)
    app.enableGraphiQL()
}
