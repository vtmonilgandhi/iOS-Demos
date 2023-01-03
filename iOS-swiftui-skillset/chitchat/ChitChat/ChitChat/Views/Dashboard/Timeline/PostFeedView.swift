//
//  PostFeedView.swift
//  ChitChat
//
//  Created by Gandhi Monil on 26/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct PostFeedView : View {
    let user: User
    @State var feedText = ""
    @State var showImagePicker: Bool = false
    @State var image = Image("")
    @State var isSheetShowing: Bool = false
    @State var privacy = "Only me"
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Who can see your post?"),
                    message: Text("Your post will in appear in Timeline and in your profile."),
                    buttons: [
                        .default(Text("Only Me"), action: {
                            self.privacy = "Only Me"
                            self.isSheetShowing = false
                        }),
                        .default(Text("Public"), action: {
                            self.isSheetShowing = false
                            self.privacy = "Public"
                        }),
                        .default(Text("Friend"), action: {
                            self.privacy = "Friend"
                            self.isSheetShowing = false
                        })
            ]
        )
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 20) {
                    Image(user.name ?? "")
                        .resizable()
                        .frame(width: 70.0, height: 70.0)
                        .clipShape(Circle())
                        .overlay(Circle().stroke())
                    
                    VStack(spacing: 20) {
                        Text(user.name ?? "")
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                self.isSheetShowing = true
                            }) {
                                Text(privacy)
                                    .foregroundColor(Color.black)
                            }.padding([.top, .bottom], 8)
                                .padding([.trailing, .leading], 10)
                                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray))
                                .actionSheet(isPresented: $isSheetShowing) {
                                    self.actionSheet
                            }
                            
                            Button(action: {
                                withAnimation {
                                    self.showImagePicker.toggle()
                                }
                            }) {
                                Text("Album")
                                    .foregroundColor(Color.black)
                            }.padding([.top, .bottom], 8)
                                .padding([.trailing, .leading], 15)
                                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray))
                        }
                    }
                }
                .padding()
                
                
                TextField("Type Something Here", text: $feedText) {
                    
                }
                .multilineTextAlignment(.leading)
                .lineLimit(10)
                .padding()
                
                image
                    .resizable()
                
                Spacer()
            }
            .navigationBarBackButtonHidden(false)
            .navigationBarHidden(false)
            .navigationBarTitle("Feed", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {}) {
                Text("Post")
                    .foregroundColor(Color.white)
            })
            
            if (showImagePicker) {
                ImagePicker(isShown: $showImagePicker, image: $image)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#if DEBUG
struct PostFeedView_Previews : PreviewProvider {
    static var previews: some View {
        PostFeedView(user: userData)
    }
}
#endif
