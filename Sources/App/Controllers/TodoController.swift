import Fluent
import Vapor

struct TodoController {
    
    private func getTodoIdParam(_ req: Request) throws -> UUID {
        guard
            let rawId = req.parameters.get("id"),
            let id = UUID(rawId)
        else {
            throw Abort(.badRequest, reason: "Invalid parameter \"id\"")
        }
        return id
    }

    private func findTodoByIdParam(_ req: Request) throws -> EventLoopFuture<Todo> {
        Todo
            .find(try getTodoIdParam(req), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // MARK: - Endpoints
    
    func get(req: Request) throws -> EventLoopFuture<TodoGetObject> {
        try findTodoByIdParam(req).map { $0.mapGet() }
    }
    
    func list(req: Request) throws -> EventLoopFuture<Page<TodoListObject>> {
        Todo
            .query(on: req.db)
            .paginate(for: req)
            .map { $0.map { $0.mapList() } }
    }
    
    func create(req: Request) throws -> EventLoopFuture<TodoGetObject> {
       let input = try req.content.decode(TodoCreateObject.self)
       let todo = Todo()
       todo.create(input)
       return todo.create(on: req.db).map { todo.mapGet() }
   }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        try findTodoByIdParam(req)
        .flatMap({
            $0.delete(on: req.db)
        })
        .map({ .ok})
    }
}
