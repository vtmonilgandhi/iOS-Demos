//
//  ContentView.swift
//  Understanding-ObservableObject
//
//  Created by Mohammad Azam on 8/2/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var fancyTimer = FancyTimer()
    
    var body: some View {
        Text("\(self.fancyTimer.value)")
            .font(.largeTitle)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
