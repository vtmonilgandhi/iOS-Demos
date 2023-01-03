//
//  ContentView.swift
//  ChitChat
//
//  Created by Gandhi Monil on 15/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI
import Combine

struct LoginView : View {
    
    @State var email = ""
    @State var password = ""
    @State var isRemember = false
    @State var isSpinnerShowing = false
    @EnvironmentObject var model: Model
    
    var body: some View {
        LoadingView(isShowing: $isSpinnerShowing) {
            NavigationView {
                VStack(alignment: .center, spacing: 100.0) {
                    VStack {
                        VStack {
                            Image("chat")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            Spacer()
                                .frame(height: 100.0)
                        }
                        
                        VStack(alignment: .center, spacing: 40.0) {
                            
                            TextField("Email", text: self.$email)
                                .modifier(TextFieldModifier())
                            TextField("Passowrd", text: self.$password)
                                .modifier(TextFieldModifier())
                        }
                        
                        Spacer()
                            .frame( height: 60.0)
                        
                        VStack(alignment: .center, spacing: 40.0) {
                            
                            NavigationLink(destination: DashboardView().environmentObject(self.model), isActive: self.$model.showSecondView) {
                                Text("Login")
                                    .foregroundColor(Color.white)
                                
                            }.hidden()
                            Button("Login") {
                                self.isSpinnerShowing = true
                                self.login()
                            }.padding(.all)
                                .frame(width: 350, height: 45)
                                .background(Color.red)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                                .font(Font.body.bold())
                                
                                .alert(isPresented: self.$model.showErrorMessage) {
                                    Alert(title: Text("Alert"), message: Text("Please check your Email and Password"), dismissButton: .default(Text("OK")))
                            }
                            
                            HStack(alignment: .center, spacing: 20.0) {
                                Text("Remember Me")
                                RedToggle()
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 100.0) {
                        NavigationLink(destination: RegistrationView()) {
                            Text("Create Account")
                                .foregroundColor(Color.red)
                        }
                        Button("Forgot Password ?") {
                            //                        PresentationLink("Forgot Password ?", destination: RegistrationView())
                        }.foregroundColor(Color.red)
                    }.padding()
                }
            }
        }
    }
    func login() {
        
        FirestoreModel.shared.login(email: email,
                                    password: password,
                                    success: {
                                        self.model.showSecondView.toggle()
                                        self.isSpinnerShowing = false
                                        FirestoreModel.shared.getUserData(email: self.email)
        }) { (error) in
            self.model.showErrorMessage.toggle()
            self.isSpinnerShowing = false
        }
    }
    
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(Model())
    }
}
