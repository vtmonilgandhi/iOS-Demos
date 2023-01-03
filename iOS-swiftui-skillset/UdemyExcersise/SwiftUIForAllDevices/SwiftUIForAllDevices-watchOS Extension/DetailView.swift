//
//  DetailView.swift
//  PictureBox-watchOS Extension
//
//  Created by Mohammad Azam on 9/7/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let animal: Animal
    
    var body: some View {
        VStack {
            Text(animal.image)
                .font(.custom("Arial",size: 100))
            Text(animal.name)
            Text(animal.description)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(animal: Animal(name: "Cat", description: "This is a cat", image: "🐈"))
    }
}
