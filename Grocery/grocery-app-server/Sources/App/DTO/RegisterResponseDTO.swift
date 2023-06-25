//
//  RegisterResponseDTO.swift
//  
//
//  Created by Bhishak Sanyal on 25/06/23.
//

import Foundation
import Vapor

struct RegisterResponseDTO: Content {
    let error: Bool
    var reason: String? = nil
}
