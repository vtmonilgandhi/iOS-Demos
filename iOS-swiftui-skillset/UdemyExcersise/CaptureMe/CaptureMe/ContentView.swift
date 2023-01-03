//
//  ContentView.swift
//  CaptureMe
//
//  Created by Monil Gandhi on 06/10/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowImagePicker: Bool = false
    @State private var image: Image? = nil
    
    
    var body: some View {
        VStack {
            
            image?.resizable()
                .scaledToFit()
            
            Button("Open Camera") {
                self.isShowImagePicker = true
            }.padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(10)
        }.sheet(isPresented: self.$isShowImagePicker, content: {
            PhotoCaptureView(showImagePicker: self.$isShowImagePicker, image: self.$image)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
