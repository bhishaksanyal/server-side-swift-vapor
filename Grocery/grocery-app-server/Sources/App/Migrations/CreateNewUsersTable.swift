//
//  CreateNewUsersTable.swift
//  
//
//  Created by Bhishak Sanyal on 24/06/23.
//

import Foundation
import Fluent

let SCHEMA: String = "users"

struct CreateNewUsersTable: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema(SCHEMA)
            .id()
            .field("username", .string, .required).unique(on: "username")
            .field("password", .string, .required)
            .field("createdOn", .datetime, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(SCHEMA)
            .delete()
    }
    
}
