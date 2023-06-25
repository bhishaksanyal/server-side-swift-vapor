//
//  LoginResponseDTO.swift
//  
//
//  Created by Bhishak Sanyal on 25/06/23.
//

import Foundation
import Vapor 

struct LoginResponseDTO: Content {
    let error: Bool
    var reason: String? = nil
    let token: String?
    let userId: UUID
}
