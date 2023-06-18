import Vapor

func routes(_ app: Application) throws {
    
    // create movie
    app.post("movies") { req async throws in
        let movie = try req.content.decode(Movie.self)
        try await movie.save(on: req.db)
        return movie
    }
    
    // get all movies
    // /movies
    app.get("movies") { req async throws in
        try await Movie.query(on: req.db)
            .all()
    }
    
    // get movie by id
    // /movies/E0FC2AEA-4EAA-4BD4-91C2-0306FFC6F47D
    app.get("movies", ":id") { req async throws in
        guard let movie = try await Movie.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.badRequest)
        }
        
        return movie
    }
    
    // delete a movie
    // movies/E0FC2AEA-4EAA-4BD4-91C2-0306FFC6F47D
    app.delete("movies", ":id") { req async throws in
        guard let movie = try await Movie.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.badRequest)
        }
        
        try await movie.delete(on: req.db)
        return movie
    }
    
    // update a movie
    // /movies
    app.put("movies") { req async throws in
        let movie = try req.content.decode(Movie.self)
        guard let movieToUpdate = try await Movie.find(movie.id, on: req.db) else {
            throw Abort(.badRequest)
        }
        
        movieToUpdate.title = movie.title
        
        try await movieToUpdate.update(on: req.db)
        
        return movieToUpdate
    }
    
}
