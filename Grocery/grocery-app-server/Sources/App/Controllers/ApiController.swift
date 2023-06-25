//
//  ApiController.swift
//  
//
//  Created by Bhishak Sanyal on 25/06/23.
//

import Foundation
import Vapor
import Fluent

// api/register
// api/login

extension Date {
    static var currentTimeStamp: String{
        return String(Date().timeIntervalSince1970 * 1000)
    }
}

class ApiController: RouteCollection {
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        let api = routes.grouped("api")
        
        // api/login
        api.post("login", use: login)
        
        // api/register
        api.post("register", use: register)
    }
    
    func login(req: Request) async throws -> LoginResponseDTO {
        
        // decode the request
        let user = try req.content.decode(User.self)
        
        // check if the user exists in the database
        guard let existingUser = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() else {
            throw Abort(.badRequest)
        }
        
        // validate the password
        let result = try await req.password.async.verify(user.password, created: existingUser.password)
        
        if !result {
            throw Abort(.unauthorized)
        }
        
        // generate the token and return it to the user
        let authPayload = try AuthPayload(expiration: .init(value: .distantFuture), userId: existingUser.requireID())
        return try LoginResponseDTO(error: false, token: req.jwt.sign(authPayload), userId: existingUser.requireID())
        
    }
    
    func register(req: Request) async throws -> RegisterResponseDTO {
        
        try User.validate(content: req)
        
        let user = try req.content.decode(User.self)
        
        if let _ = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() {
            throw Abort(.conflict, reason: "Username is already taken")
        }
        
        // hash password
        user.password = try await req.password.async.hash(user.password)
        
        // save on db
        try await user.save(on: req.db)
        
        return RegisterResponseDTO(error: false)
    }
    
}
