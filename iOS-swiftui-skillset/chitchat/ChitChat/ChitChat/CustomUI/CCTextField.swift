//
//  CCTextField.swift
//  ChitChat
//
//  Created by Gandhi Monil on 26/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//
import SwiftUI
import Combine

final class UserData: ObservableObject  {
    
    let didChange = PassthroughSubject<UserData, Never>()
    
    var text = "Type Something Here" {
        didSet {
            didChange.send(self)
        }
    }
    
    init(text: String) {
        self.text = text
    }
}

struct CCTextField: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
