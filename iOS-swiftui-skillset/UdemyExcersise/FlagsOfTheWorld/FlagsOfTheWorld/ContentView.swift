//
//  ContentView.swift
//  FlagsOfTheWorld
//
//  Created by Mohammad Azam on 7/18/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let flags = ["🇦🇽","🇩🇿","🇵🇰","🇺🇸","🇹🇷","🇧🇷"]
    @State private var flagVM: FlagViewModel = FlagViewModel()
    
    var body: some View {
        List {
            
            Text(self.flagVM.country)
            
            ForEach(self.flags, id: \.self) { flag in
                
                HStack {
                    
                    Text(flag)
                        .font(.custom("Arial",size: 100))
                    Spacer()
                    
                }.tapAction {
                    self.flagVM.flag = flag
                    self.flagVM.showModal.toggle()
                }
                
            }
            
        }.sheet(isPresented: self.$flagVM.showModal) {
            FlagDetailView(flagVM: self.$flagVM)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
