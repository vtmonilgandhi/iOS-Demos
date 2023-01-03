//
//  ContentView.swift
//  Shared
//
//  Created by Mohammad Azam on 6/30/20.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isDarkMode")
    private var isDarkMode: Bool = false
    
    var body: some View {
        VStack {
            Text(isDarkMode ? "DARK" : "LIGHT")
            Toggle(isOn: $isDarkMode) {
                Text("Select Mode")
            }.fixedSize()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
