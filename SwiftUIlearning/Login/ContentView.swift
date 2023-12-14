//
//  ContentView.swift
//  SwiftUIlearning
//
//  Created by Zeeshan Suleman on 11/14/23.
//

import SwiftUI

struct ContentView: View {
    @State var userName: String = ""
    @ObservedObject var loginVm = LoginVm()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("A sample login screen")
                    .padding(.top, 20)
                Spacer()
                TextField("UserName", text: $loginVm.userEmail)
                    .frame(height: 40)
                    .padding(.leading)
                    .border(.gray)
                TextField("password", text: $loginVm.password)
                    .frame(height: 40)
                    .padding(.leading)
                    .border(.gray)
                    .padding(.top)
                Spacer()
                Button {
                    if(loginVm.validateUserInputs()){
                        loginVm.postLoginRequest()
                    }
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(5)
                }
                Button {
//                    if(loginVm.validateUserInputs()){
//                        //                        loginVm.postLoginRequest()
//                    }
                } label: {
                    Text("Create Account")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(5)
                }
            }
            .navigationDestination(isPresented: $loginVm.navigate) {
                HomeView()
            }
            .overlay(alignment: .center, content: {
                if loginVm.isApiCalling {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1)
                }
               
            })
            .padding(40)
            .alert(loginVm.errorMsg, isPresented: $loginVm.isPresentingAlert) {
                Button("Ok", role: .cancel) { }
            }
            
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        HomeView()
    }
}
