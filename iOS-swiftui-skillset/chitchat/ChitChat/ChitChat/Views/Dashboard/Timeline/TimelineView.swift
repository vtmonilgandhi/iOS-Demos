//
//  TimelineView.swift
//  ChitChat
//
//  Created by Gandhi Monil on 16/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct TimelineView : View {
    
    @State private var searchQuery: String = ""
   
    var timeline: [Timeline] = []
    
    var body: some View {
        VStack {
            SearchBar(text: self.$searchQuery)  
            NavigationLink(destination: PostFeedView(user: userData)) {
                HStack(alignment: .center) {
                    Spacer()
                        .frame(width: 30)
                    Image("CameraIcon")
                        .resizable()
                        .frame(width: 40.0 , height: 40.0)
                    Spacer()
                        .frame(width: 30)
                    Text("Whats in your mind ?")
                    Spacer()
                }
            }.foregroundColor(Color.black)
            
            Rectangle()
                .foregroundColor(Color.gray)
                .frame(height: 1.0)
                .shadow(color: Color.gray, radius: 4)
            ScrollView {
                ForEach(timeline) { item in
                    TimelineCell(timeline: item)
                        .padding()
                }
            }
        }.navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
}

#if DEBUG
struct TimelineView_Previews : PreviewProvider {
    static var previews: some View {
        TimelineView(timeline: testData)
    }
}
#endif
