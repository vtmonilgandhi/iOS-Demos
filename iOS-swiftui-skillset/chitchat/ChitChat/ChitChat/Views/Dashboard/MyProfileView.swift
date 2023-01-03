//
//  MyProfileView.swift
//  ChitChat
//
//  Created by Milankumar-Remote on 13/08/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var model: Model
    var body: some View {
        VStack {
            Form {
                Section {
                    VStack {
                        NavigationLink(destination: UpdateProfileView()) {
                            HStack(alignment: .center) {
                                Image(userData.userImage ?? "")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke())
                                Spacer()
                                    .frame(width: 30)
                                Text(userData.name ?? "")
                                Spacer()
                            }
                        }
                        
                        NavigationLink(destination: UpdateProfileView()) {
                            HStack(alignment: .center) {
                                Image("edit")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                Spacer()
                                    .frame(width: 30)
                                Text("Edit Profile")
                                Spacer()
                            }
                        }
                    }
                }
            }.frame(height: 200.0)
            
            NavigationLink(destination: LoginView()) {
                Text("Logout")
                    .foregroundColor(Color.white)
            }
            .padding(.all)
            .frame(width: 350, height: 45)
            .background(Color.red)
            .cornerRadius(20)
            .foregroundColor(.white)
            .font(Font.body.bold())
            Spacer()
        }.navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView().environmentObject(Model())
    }
}
