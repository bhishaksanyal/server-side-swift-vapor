//
//  File.swift
//  
//
//  Created by Bhishak Sanyal on 08/06/23.
//

import Foundation
import Vapor

struct AuthMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        guard let auth = request.headers.bearerAuthorization else {
            throw Abort(.unauthorized)
        }
        
        print(auth.token)
        return try await next.respond(to: request)
    }
}
