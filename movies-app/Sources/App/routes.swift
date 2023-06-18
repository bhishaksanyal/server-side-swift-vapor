import Vapor

func routes(_ app: Application) throws {
    
    // create movie
    app.post("movies") { req async throws in
        let movie = try req.content.decode(Movie.self)
        try await movie.save(on: req.db)
        return movie
    }
    
    // fetch movies
    app.get("movies") { req async throws in
        try await Movie.query(on: req.db)
            .all()
    }
}
