//
//  CustomTextField.swift
//  ChitChat
//
//  Created by Gandhi Monil on 16/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct TextFieldModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .frame( height: 40.0)
    }
}

struct ImageModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(50)
            .frame(width: 100.0, height: 100.0)
    }
}

struct PaddingModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
    }
}
