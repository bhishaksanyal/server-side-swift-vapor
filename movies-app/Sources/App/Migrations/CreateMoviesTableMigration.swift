//
//  CreateMoviesTableMigration.swift
//  
//
//  Created by Bhishak Sanyal on 10/06/23.
//

import Foundation
import Fluent

struct CreateMoviesTableMigration: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        // create movies table
        try await database.schema("movies")
            .id()
            .field("title", .string, .required)
            .create()
        
    }
    
    func revert(on database: Database) async throws {
        // delete movies table
        try await database.schema("movies")
            .delete()
    }
    
}
