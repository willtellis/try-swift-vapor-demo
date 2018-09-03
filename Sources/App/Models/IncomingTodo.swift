//
//  IncomingTodo.swift
//  App
//
//  Created by Will Ellis on 9/3/18.
//

import Vapor

extension Todo {
    struct IncomingTodo: Content {
        var title: String?
        var completed: Bool?
        var order: Int?

        func makeTodo() -> Todo {
            return Todo(
                id: nil,
                title: title ?? "",
                completed: completed ?? false,
                order: order
            )
        }
    }
}
