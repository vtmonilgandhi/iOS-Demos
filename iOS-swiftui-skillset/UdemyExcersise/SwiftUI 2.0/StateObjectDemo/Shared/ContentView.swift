//
//  ContentView.swift
//  Shared
//
//  Created by Mohammad Azam on 6/26/20.
//

import SwiftUI

class Counter: ObservableObject {
    @Published var value: Int = 0
}

struct CounterView: View {
    
    @StateObject var counter = Counter()
    
    var body: some View {
        VStack {
            Text("\(counter.value)")
            Button("Counter View Increment") {
                counter.value += 1
            }
        }.padding()
        .background(Color.green)
    }
}

struct ContentView: View {
    
    @State private var count: Int = 0
    
    var body: some View {
        VStack {
            Text("CONTENT VIEW")
            Text("\(count)")
            Button("Increment ContentView Counter") {
                count += 1
            }
                
            CounterView()
        }.padding()
        .background(Color.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
