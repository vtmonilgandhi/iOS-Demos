//
//  UpdateProfileView.swift
//  ChitChat
//
//  Created by Milankumar-Remote on 13/08/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct UpdateProfileView: View {
    
    let userData = FirestoreModel.shared.user
    @State var name = ""
    @State var number = ""
    @State var dob = ""
    @State var town = ""
    @State var showImagePicker: Bool = false
    @State var image = Image("CameraIcon")
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(alignment: .center, spacing: 40) {
                    VStack {
                            image
                                .resizable()
                                .modifier(ImageModifier())
                        
                        Spacer()
                            .frame(height: 20)
                        Button(action: {
                            withAnimation {
                                self.showImagePicker.toggle()
                            }
                        }) {
                            Text("Edit Photo")
                        }
                        .foregroundColor(Color.red)
                    }
                    
                    VStack(alignment: .center, spacing: 30) {
                        
                        TextField("Name", text: $name)
                            .modifier(TextFieldModifier())
                        TextField("Mobile No:", text: $number)
                            .modifier(TextFieldModifier())
                        TextField("Birthday", text: $dob)
                            .modifier(TextFieldModifier())
                        TextField("Home Town", text: $town)
                            .modifier(TextFieldModifier())
                    }
                    
                    Spacer()
                        .frame(height: 40)
                    
                    Button("Submit") {
                        
                    }
                    .frame(width: 350, height: 45)
                        .background(Color.red)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .font(Font.body.bold())
                }
            }
            if (showImagePicker) {
                ImagePicker(isShown: $showImagePicker, image: $image)
                .edgesIgnoringSafeArea(.all)
            }
        }.navigationBarTitle(Text("Update"), displayMode: .inline)

        .onAppear {
            self.name = self.userData.name ?? ""
            self.number = self.userData.phone ?? ""
            self.dob = self.userData.birthday ?? ""
            self.town = self.userData.homeTown ?? ""
        }
    }
}

struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView()
    }
}
