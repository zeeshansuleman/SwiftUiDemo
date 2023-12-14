//
//  LoginVm.swift
//  SwiftUIlearning
//
//  Created by Zeeshan Suleman on 11/21/23.
//

import Foundation



class LoginVm : ObservableObject {
    
    @Published var userEmail: String = ""
    @Published var password: String = ""
    @Published var errorMsg: String = ""
    @Published var isPresentingAlert: Bool = false
    @Published var navigate: Bool = false
    @Published var isApiCalling: Bool = false



    private let loginValidation = LoginValidation()
    private let loginResource = LoginResource()
    
   
    
    func validateUserInputs()->Bool {
        let result = loginValidation.validateuserInputs(email: userEmail, password: password)
        if (result.success == false) {
            errorMsg = result.errorMsg ?? "error occured"
            isPresentingAlert = true
            return false
        }
        return true
    }
    
    
    func postLoginRequest() {
        let userName = "kminchelle"
        let password = "0lelplR"
        self.isApiCalling = true

        let loginRequest = LoginRequest(username: userName, password: password)
        loginResource.authenticate(loginRequest: loginRequest) { result in
            self.isApiCalling = false
            switch result {
            case .success(let response):
                print(response)
                self.navigate = true
            case .failure(let error):
                print(error)
                self.errorMsg = "error occured"
                self.isPresentingAlert = true
            }
        }
    }
}
