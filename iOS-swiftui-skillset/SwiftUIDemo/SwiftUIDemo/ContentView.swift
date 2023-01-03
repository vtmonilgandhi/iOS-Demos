//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Monil Gandhi on 18/06/19.
//  Copyright © 2019 Volansys. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    var tutors: [Tutor] = []
    
    var body: some View {
        NavigationView {
            List(tutors) { tutor in
                NavigationLink(destination: Text(tutor.name)) {
                    Image(tutor.imageName).cornerRadius(40)
                    VStack(alignment: .leading){
                        Text(tutor.name)
                        Text(tutor.headline)
                            .font(.subheadline)
                            .color(.gray)
                    }
                }
                }
                .navigationBarTitle(Text("Tutors"))
        }
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(tutors: testData)
    }
}
#endif
