//
//  ContentView.swift
//  simultaneousGesture
//
//  Created by Monil Gandhi on 09/04/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Circle()
                .fill(Color.red)
                .frame(width: 200, height: 200)
                .onTapGesture {
                    print("Circle tapped")
                }
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    print("VStack tapped")
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
