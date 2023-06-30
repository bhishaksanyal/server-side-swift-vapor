//
//  String+Extensions.swift
//  GroceryApp
//
//  Created by Bhishak Sanyal on 29/06/23.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
