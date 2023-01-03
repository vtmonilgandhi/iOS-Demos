//
//  RedToggle.swift
//  ChitChat
//
//  Created by Gandhi Monil on 16/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct RedToggle : UIViewRepresentable {
    func makeUIView(context: Context) -> UISwitch {
        UISwitch()
    }
    
    func updateUIView(_ uiView: UISwitch, context: Context) {
        uiView.onTintColor = UIColor.red
    }
}
