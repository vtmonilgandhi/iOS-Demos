//
//  ContentView.swift
//  SequenceGesture
//
//  Created by Monil Gandhi on 09/04/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var state = CGSize.zero
    @State var isDraggable = false
    @State var translation = CGSize.zero
    
    let minimumLongPressDuration = 1.0
    
    var body: some View {
        
        // Long Tap Gesture
        let longTap = LongPressGesture(minimumDuration: minimumLongPressDuration).onEnded { value in
            self.isDraggable = true
        }
        
        // Drag Gesture
        let drag = DragGesture().onChanged { value in
            self.translation = value.translation
            self.isDraggable = true
        }.onEnded { value in
            self.state.width += value.translation.width
            self.state.height += value.translation.height
            self.translation = .zero
            self.isDraggable = false
        }
        
        // Sequence Gesture
        let sequenceGesture = longTap.sequenced(before: drag)
        
        return Circle()
            .fill(Color.red)
            .overlay(isDraggable ? Circle().stroke().stroke(Color.white, lineWidth: 2) : nil)
            .frame(width: 100, height: 100, alignment: .center)
            .offset(x: state.width + translation.width, y: state.height + translation.height)
            .shadow(radius: isDraggable ? 8 : 0)
            .animation(.linear(duration: minimumLongPressDuration))
            .gesture(sequenceGesture)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
