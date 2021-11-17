import Fluent
import Vapor
import Leaf

struct TodoRouter: RouteCollection {

    func boot(routes: RoutesBuilder) throws {

        let id = PathComponent(stringLiteral: ":id")
        
        let todoController = TodoController()
        let todoRoutes = routes.grouped("todos")
        
        todoRoutes.get(use: todoController.list)
        todoRoutes.post(use: todoController.create)
        todoRoutes.get(id, use: todoController.get)
        
        routes.get(use: indexHandler)
    }
    
    func indexHandler(_ req: Request) -> EventLoopFuture<View> {
        return req.view.render("index")
    }
}
