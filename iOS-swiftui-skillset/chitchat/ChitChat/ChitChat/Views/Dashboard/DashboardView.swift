//
//  Demo.swift
//  ChitChat
//
//  Created by Gandhi Monil on 25/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct DashboardView : View {
    @EnvironmentObject var model: Model
    var body: some View {
        TabView {
            TimelineView(timeline: testData)
                .tabItem {
                    Image(systemName: "photo.on.rectangle")
            }
            
            TimelineView(timeline: testData)
                .tabItem {
                    Image(systemName: "person")
            }
            
            MyProfileView()
                .tabItem {
                    Image(systemName: "line.horizontal.3")
            }
        }.accentColor(Color.red)
    }
}

struct Demo_Previews : PreviewProvider {
    static var previews: some View {
        DashboardView().environmentObject(Model())
    }
}
