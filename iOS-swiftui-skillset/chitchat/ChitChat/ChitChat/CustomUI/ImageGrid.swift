//
//  DEMO.swift
//  ChitChat
//
//  Created by Gandhi Monil on 24/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct SingleImage : View {
    
    let imageName: String
    
    var body: some View {
        
        Image("\(imageName)")
            .resizable()
    }
}

struct TwoImage : View {
    
    let firstImage: String
    let secondImage: String
    
    var body: some View {
        
        HStack {
            Image("\(firstImage)")
                .resizable()
            
            Image("\(secondImage)")
                .resizable()
        }
    }
}

struct ThreeImage : View {
    
    let firstImage: String
    let secondImage: String
    let thirdImage: String
    
    var body: some View {
        HStack {
            Image("\(firstImage)")
                .resizable()
            
            VStack {
                Image("\(secondImage)")
                    .resizable()
                
                Image("\(thirdImage)")
                    .resizable()
            }
        }
    }
}

struct FourImage : View {
    
    let firstImage: String
    let secondImage: String
    let thirdImage: String
    let fourthImage: String
    
    var body: some View {
        HStack {
            VStack {
                Image("\(firstImage)")
                    .resizable()
                
                Image("\(secondImage)")
                    .resizable()
            }
            VStack {
                Image("\(thirdImage)")
                    .resizable()
                
                Image("\(fourthImage)")
                    .resizable()
            }
        }
    }
}

#if DEBUG
struct DEMO_Previews : PreviewProvider {
    static var previews: some View {
        FourImage(firstImage: "thomas_edison", secondImage: "thomas_edison", thirdImage: "thomas_edison", fourthImage: "thomas_edison")
    }
}
#endif
