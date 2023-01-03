//
//  RegistrationView.swift
//  ChitChat
//
//  Created by Gandhi Monil on 16/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

class Model: ObservableObject {
    @Published var showErrorMessage = false
    @Published var showSecondView = false
}

struct RegistrationView : View {
    
    @EnvironmentObject var model: Model
    @State var name = ""
    @State var password = ""
    @State var email = ""
    @State var number = ""
    @State var dob = ""
    @State var town = ""
    @State var isSpinnerShowing = false
    @State var showImagePicker: Bool = false
    @State var image = Image("CameraIcon")
    
    var body: some View {
        LoadingView(isShowing: $isSpinnerShowing) {
            ZStack {
                ScrollView {
                    VStack(alignment: .center, spacing: 40) {
                        VStack {
                            self.image
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
                            
                            TextField("Name", text: self.$name)
                                .modifier(TextFieldModifier())
                            TextField("Password", text: self.$password)
                                .modifier(TextFieldModifier())
                            TextField("Email", text: self.$email)
                                .modifier(TextFieldModifier())
                            TextField("Mobile No:", text: self.$number)
                                .modifier(TextFieldModifier())
                            TextField("Birthday", text: self.$dob)
                                .modifier(TextFieldModifier())
                            TextField("Home Town", text: self.$town)
                                .modifier(TextFieldModifier())
                        }
                        
                        NavigationLink(destination: DashboardView().environmentObject(self.model), isActive: self.$model.showSecondView) {
                            Text("Submit")
                                .foregroundColor(Color.white)
                            
                        }.hidden()
                        Button("Submit") {
                            self.isSpinnerShowing = true
                            self.submitData()
                        }.padding(.all)
                            .frame(width: 350, height: 45)
                            .background(Color.red)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .font(Font.body.bold())
                            .alert(isPresented: self.$model.showErrorMessage) {
                                Alert(title: Text("Alert"), message: Text("Please Provide Other Email Id"), dismissButton: .default(Text("OK")))
                        }
                    }
                }
                if (self.showImagePicker) {
                    ImagePicker(isShown: self.$showImagePicker, image: self.$image)
                        .edgesIgnoringSafeArea(.all)
                }
            }.navigationBarTitle(Text("Register"), displayMode: .inline)
        }
    }
    
    func submitData() {
    
//        ImageManager.shared.uploadImage(image: image) {
//            print("Success")
//        }
        FirestoreModel.shared.addData(name: name,
                                      email: email,
                                      birthdate: dob,
                                      phone: number,
                                      city: town,
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

struct RegistrationView_Previews : PreviewProvider {
    static var previews: some View {
        RegistrationView().environmentObject(Model())
    }
}
