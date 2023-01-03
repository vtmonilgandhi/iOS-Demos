//
//  FlagDetailView.swift
//  FlagsOfTheWorld
//
//  Created by Mohammad Azam on 7/18/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct FlagDetailView: View {
    
    @Binding var flagVM: FlagViewModel
    
    var body: some View {
        VStack {
            
            Text(self.flagVM.flag)
                .font(.custom("Arial",size: 200))
            
            TextField(self.$flagVM.country, placeholder: Text("Enter country name"))
                .padding()
                .fixedSize()
            
            Button("Submit") {
                self.flagVM.showModal.toggle()
            }
            
            
        }
    }
}

#if DEBUG
struct FlagDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlagDetailView(flagVM: .constant(FlagViewModel()))
    }
}
#endif
