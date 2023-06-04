//
//  File.swift
//  
//
//  Created by Bhishak Sanyal on 04/06/23.
//

import Foundation
import Vapor

struct HotelQuery: Content {
    let sort: String
    let search: String?
}
