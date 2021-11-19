import Fluent
import Vapor
import Leaf

struct TodoRouter: RouteCollection {

    func boot(routes: RoutesBuilder) throws {

        let id = PathComponent(stringLiteral: ":id")
        
        let todoController = TodoController()
        let todoRoutes = routes.grouped("todos")
        
        // GET /todos
        // POST /todos
        // GET /todos/:id
        todoRoutes.get(use: todoController.list)
        todoRoutes.post(use: todoController.create)
        todoRoutes.get(id, use: todoController.get)
        todoRoutes.delete(id, use: todoController.delete)
    }
}
