//
//  ContentView.swift
//  SwiftUIForAllDevices
//
//  Created by Mohammad Azam on 9/12/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private var animals = AnimalService.getAll()
    
    var body: some View {
        
        NavigationView {
        
        List(self.animals, id:\.name) { animal in
            
            NavigationLink(destination: SharedDetailView(animal: animal)) {
            
                HStack {
                    Text(animal.image)
                        .font(.custom("Arial",size: 100))
                    Text(animal.name)
                        .font(.title)
                }
            }
        }
            
        .navigationBarTitle("Animals")
        
        }
    
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
