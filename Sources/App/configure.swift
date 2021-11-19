import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    
    app.http.server.configuration.hostname = "127.0.0.1"
    app.http.server.configuration.port = 8080
    
    app.databases.use(.sqlite(.memory), as: .sqlite)

    app.migrations.add(TodoMigation())
    try app.autoMigrate().wait()
    
    // register routes
    try TodoRouter().boot(routes: app.routes)
    try WebsiteRouter().boot(routes: app.routes)
    
    app.views.use(.leaf)
}
