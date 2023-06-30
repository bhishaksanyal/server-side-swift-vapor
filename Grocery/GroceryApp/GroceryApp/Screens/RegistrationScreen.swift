//
//  RegistrationScreen.swift
//  GroceryApp
//
//  Created by Bhishak Sanyal on 29/06/23.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    private var isValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && (password.count > 6) && (password.count < 11)
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            
            Button("Register") {
                
            }
            .buttonStyle(.borderless)
            .disabled(!isValid)
        }
    }
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreen()
    }
}
