//
//  OutgoingTodo.swift
//  App
//
//  Created by Will Ellis on 9/3/18.
//

import Vapor

extension Todo {
    struct Outgoing: Content {
        var id: Int?
        var title: String?
        var completed: Bool?
        var order: Int?
        var url: String
    }
}

extension Todo {
    func makeOutgoing(with req: Request) throws -> Outgoing {
        let idString = id?.description ?? ""
        let url = req.baseURL + idString
        return Outgoing.init(id: id, title: title, completed: completed, order: order, url: url)
    }
}
