//
//  FancyScoreView.swift
//  ObservableObjectAnotherExample
//
//  Created by Mohammad Azam on 8/3/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct FancyScoreView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        VStack {
            Text("\(self.userSettings.score)")
            Button("Increment Score") {
                self.userSettings.score += 1
            }.padding().background(Color.green)
            
        }.padding().background(Color.orange)
    }
}

#if DEBUG
struct FancyScoreView_Previews: PreviewProvider {
    static var previews: some View {
        FancyScoreView()
    }
}
#endif
