//
//  ContentView.swift
//  ExclusiveGesture
//
//  Created by Monil Gandhi on 09/04/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var degree = 0.0
    @State var isDay = false
    
    var body: some View {
        Image(systemName: isDay ? "sun.min" : "moon")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .rotationEffect(Angle.degrees(degree))
            .gesture(TapGesture(count: 1)
                        .onEnded({ _ in
                            self.isDay.toggle()
                        })
                        
                        .exclusively(before: RotationGesture()
                                        .onChanged({ angle in
                                            self.degree = angle.degrees
                                        })
                        )
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
