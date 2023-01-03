//
//  ContentView.swift
//  SwiftUIRatings
//
//  Created by Mohammad Azam on 6/20/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

extension Image {
    func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
}

struct ContentView: View {
    
    @State private var rating: Int?
    
    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .resizedToFill(width: 150, height: 150)  
            
            RatingView(rating: $rating)
             Text(rating != nil ? "You rating: \(rating!)" : "")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
