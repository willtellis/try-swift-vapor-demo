import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class TodoController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Todo.Outgoing]> {
        return Todo.query(on: req).all().map { todos in
            return try todos.map { todo in
                return try todo.makeOutgoing(with: req)
            }
        }
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<Todo.Outgoing> {
        return try req.content.decode(Todo.IncomingTodo.self).flatMap { incoming -> Future<Todo> in
            let todo = incoming.makeTodo()
            return todo.save(on: req)
        }.map { todo in
            return try todo.makeOutgoing(with: req)
        }
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Todo.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .ok)
    }

    func clear(_ req: Request) throws -> Future<HTTPStatus> {
        return Todo.query(on: req).delete().transform(to: .ok)
    }
}
