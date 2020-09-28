import Vapor

func routes(_ app: Application) throws {
    let weatherProcesser = WeatherProcesser(app)
    let weatherController = WeatherController(processer: weatherProcesser)
    
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
}
