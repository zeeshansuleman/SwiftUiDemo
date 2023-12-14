//
//  LoginResponse.swift
//  SwiftUIlearning
//
//  Created by Zeeshan Suleman on 11/22/23.
//

import Foundation

struct LoginResponse: Decodable {
    let message: String?
    let username, firstName, lastName, gender, image, token, email: String
    let id: Int
}

