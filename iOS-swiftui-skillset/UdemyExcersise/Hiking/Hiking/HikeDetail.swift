//
//  HikeDetail.swift
//  Hiking
//
//  Created by Monil Gandhi on 26/08/20.
//  Copyright © 2020 Volansys Technologies. All rights reserved.
//

import SwiftUI

struct HikeDetail: View {
    
    let hike: Hike
    @State private var zoomed: Bool = false
    
    var body: some View {
        VStack {
            Image(hike.imageURL)
                .resizable()
                .aspectRatio(contentMode: self.zoomed ? .fill : .fit)
                .onTapGesture {
                    withAnimation {
                        self.zoomed.toggle()
                    }
            }
            
            Text(hike.name)
            Text(String(format: "%.2f", hike.miles))
            
        } .navigationBarTitle(Text(hike.name), displayMode: .inline)
    }
}

struct HikeDetail_Previews: PreviewProvider {
    static var previews: some View {
        HikeDetail(hike: Hike(name: "Tom, Dick, and Harry Mountain", imageURL: "tom", miles: 5.8))
    }
}
