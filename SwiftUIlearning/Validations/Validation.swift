//
//  Validation.swift
//  SwiftUIlearning
//
//  Created by Zeeshan Suleman on 11/22/23.
//

import Foundation

struct ValidationResult {
    var errorMsg: String?
    var success: Bool = false
}

struct LoginValidation {
    
    func validateuserInputs(email: String, password: String) -> ValidationResult {
        if (email == "" || password == "") {
            return ValidationResult(errorMsg: "Empty fields",success: false)
        }
//            else if !isValidEmail(value: email){
//            return ValidationResult(errorMsg: "Email is not valid",success: false)
//        }
        else {
            return ValidationResult(success: true)
        }
    }
    
    func isValidEmail(value: String)->Bool{
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
}
