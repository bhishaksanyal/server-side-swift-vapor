import Vapor
import Fluent
import FluentPostgresDriver
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.databases.use(.postgres(hostname: "localhost", username: "postgres", password: "", database: "grocerydb"), as: .psql)
    
    // register migrations
    app.migrations.add(CreateNewUsersTable())
    
    // register controllers
    try app.register(collection: ApiController())
    
    app.jwt.signers.use(.hs256(key: "SECRETKEY"))

    // register routes
    try routes(app)
}
