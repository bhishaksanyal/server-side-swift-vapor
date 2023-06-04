import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("movies") { req async -> String in
        "Movie Route"
    }
    
    // movies/action
    // movies/kids
    // movies/horror
    app.get("movies", ":genre") { req async -> String in
        let genre = req.parameters.get("genre")
        return "All movies under genre \(String(describing: genre!))"
    }
}
