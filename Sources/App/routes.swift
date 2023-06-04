import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("movies") { req async in
        [Movie(title: "Batman", year: 2020), Movie(title: "Spider Man", year: 2021), Movie(title: "Iron Man", year: 2022)]
    }
    
    app.post("movie") { req async throws in
        let movie = try req.content.decode(Movie.self)
        return movie
    }
    
    // Strongly typed route parameters
    app.get("customer", ":customerID") { req async throws -> String in
        
        guard let customerID = req.parameters.get("customerID", as: Int.self) else {
            throw Abort(.unsupportedMediaType)
        }
        
        return "Requesting for customer data with ID: \(customerID)"
    }
    
    // movies/action
    // movies/kids
    // movies/horror
    // route parameters
    app.get("movies", ":genre") { req async throws -> String in
        
        guard let genre = req.parameters.get("genre") else {
            throw Abort(.badRequest)
        }
        return "All movies under genre: \(String(describing: genre))"
    }
}
