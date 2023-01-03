//
//  ContentView.swift
//  Shared
//
//  Created by Mohammad Azam on 7/26/20.
//

import SwiftUI

struct MusicPlayerBar: View {
    
    var body: some View {
        HStack {
            
            Text("Baby Blue")
            Spacer()
            Image(systemName: "play.fill")
                .padding(.trailing, 10)
            Image(systemName: "forward.fill")
                .padding(.trailing, 10)
        }

    }
}

struct MusicPlayer: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
               
                Text("Baby Blue")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color.white)
                
                Text("Badfinger")
                    .padding(.leading, 15)
                    .foregroundColor(Color.white)
                
                Spacer()
                    
            }
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
       
       
    }
}

struct Cover: View {
    
    let frame: CGFloat
    
    var body: some View {
        Image("cover")
            .resizable()
            .frame(width: frame, height: frame)
            .cornerRadius(4)
            .padding(5)
    }
}

struct ContentView: View {
    
    @Namespace private var musicPlayerNS
    @State private var showMusicPlayer: Bool = false
    
    var frame: CGFloat {
        showMusicPlayer ? 300 : 44
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
           
            VStack {
                
                HStack {
        
                    Cover(frame: frame)
                        .padding(showMusicPlayer ? 20 : 0)
                    
                    if showMusicPlayer == false {
                        
                        MusicPlayerBar()
                            .matchedGeometryEffect(id: "animation", in: musicPlayerNS)
                          
                        Spacer()
                        
                    }
                    
                }.background(showMusicPlayer ? Color(#colorLiteral(red: 0.2270281315, green: 0.04325092584, blue: 0.04711123556, alpha: 1)) : Color.gray)
                
                if showMusicPlayer == true {
                    MusicPlayer()
                        .matchedGeometryEffect(id: "animation", in: musicPlayerNS)
                    Spacer()
                }
                
            } .background(showMusicPlayer ? Color(#colorLiteral(red: 0.2270281315, green: 0.04325092584, blue: 0.04711123556, alpha: 1)) : Color.white)
            
            .onTapGesture {
                withAnimation(.spring()) {
                    showMusicPlayer.toggle()
                }
            }
           
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


