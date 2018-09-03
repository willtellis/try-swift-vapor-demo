//
//  Request+BaseURL.swift
//  App
//
//  Created by Will Ellis on 9/3/18.
//

import Vapor

extension Request {
    var baseURL: String {
        var host = http.headers.firstValue(name: .host)!
        if host.hasSuffix("/") {
            host = String(host.dropLast())
        }
        let scheme = http.remotePeer.scheme ?? "http"
        return "\(scheme)://\(host)/todos".finished(with: "/")
    }
}
