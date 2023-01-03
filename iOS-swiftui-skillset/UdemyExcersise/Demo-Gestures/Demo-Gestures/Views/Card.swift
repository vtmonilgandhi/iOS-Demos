//
//  Card.swift
//  Demo-Gestures
//
//  Created by Mohammad Azam on 6/24/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import SwiftUI

struct Card: View {
    
    let tapped: Bool
    @State private var scale: Length = 1
    
    var body: some View {
        
        VStack {
            
            Image("cat")
                .resizable()
                .scaleEffect(self.scale)
                .frame(width: 300, height: 300)
                .gesture(MagnificationGesture()
                    .onChanged { value in
                        self.scale = value.magnitude
                    }
                )
            
            
            Text("Card")
                .font(.title)
                .color(Color.white)
            
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(self.tapped ? Color.orange : Color.purple)
            .cornerRadius(30)
        
    }
    
}

#if DEBUG

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(tapped: true)
    }
}

#endif
