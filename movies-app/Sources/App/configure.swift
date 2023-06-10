import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.databases.use(.postgres(hostname: "", username: "", password: "", database: ""), as: .psql)
    
    // register migrations
    app.migrations.add(CreateMoviesTableMigration())

    // register routes
    try routes(app)
}
