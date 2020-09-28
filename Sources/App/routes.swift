import Vapor
import GraphiQLVapor

func routes(_ app: Application) throws {
    let weatherProcesser = WeatherProcesser(app)
    let weatherController = WeatherController(processer: weatherProcesser)
    
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.register(graphQLSchema: Schemas.locationsSchema, withResolver: weatherController)
    app.enableGraphiQL()
}
