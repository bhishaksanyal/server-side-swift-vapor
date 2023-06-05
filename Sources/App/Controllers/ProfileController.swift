//
//  File.swift
//  
//
//  Created by Bhishak Sanyal on 05/06/23.
//

import Foundation
import Vapor

struct ProfileController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let profile = routes.grouped("profile")
        
        // /profile
        profile.get(use: index)
        
        // /profile/23
        profile.get(":userId", use: show)
    }
    
    func index(req: Request) async throws -> String {
        "index"
    }
    
    func show(req: Request) async throws -> String {
        guard let userId = req.parameters.get("userId") else {
            throw Abort(.custom(code: 999, reasonPhrase: "Id needs to be a valid integer"))
        }
        
        return "Got - \(userId)"
    }
    
    
}
