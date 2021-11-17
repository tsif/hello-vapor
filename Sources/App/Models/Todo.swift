import Fluent
import Vapor

struct TodoListObject: Codable {
    let id: UUID
    let title: String
    let description: String
}

struct TodoGetObject: Codable {
    let id: UUID
    let title: String
    let description: String
}

struct TodoCreateObject: Codable {
    let title: String
    let description: String
}

extension TodoGetObject: Content {}
extension TodoListObject: Content {}
extension TodoCreateObject: Content {}

final class Todo: Model, Content {
    static let schema = "todos"
    
    @ID(key: .id) var id: UUID?
    @Field(key: "title") var title: String
    @Field(key: "description") var description: String
    
    init() { }

    init(id: UUID? = nil,
         title: String,
         description: String) {
        
        self.id = id
        self.title = title
        self.description = description
    }
}

extension Todo {
    
    func mapGet() -> TodoGetObject {
        .init(id: id!, title: title, description: description)
    }
    
    func mapList() -> TodoListObject {
        .init(id: id!, title: title, description: description)
    }
    
    func create(_ input: TodoCreateObject) {
        title = input.title
        description = input.description
    }
}
