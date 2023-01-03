//
//  TimelineCell.swift
//  ChitChat
//
//  Created by Gandhi Monil on 26/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct TimelineCell : View {
    
    let timeline: Timeline
    let name = "Hello"
    @State var isSheetShowing: Bool = false
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Privacy"),
                    message: Text("Hide or Delete Post"),
                    buttons: [
                        .default(Text("Hide Post"), action: {
                            self.isSheetShowing = false
                        }),
                        .destructive(Text("Delete Post"), action: {
                            self.isSheetShowing = false
                        }),
                        .default(Text("Cancel"), action: {
                            self.isSheetShowing = false
                        })
            ]
        )
    }
    
    var body: some View {
        
        VStack {
            HStack(spacing: 20) {
                Image(timeline.name)
                    .resizable()
                    .frame(width: 50.0, height: 50.0)
                    .clipShape(Circle())
                    .overlay(Circle().stroke())
                
                //                    Text(timeline.name)
                //                        +
                Text("\(timeline.name) Posted this feed")
                    .font(.subheadline)
                    .fontWeight(.bold)
                //                    .lineLimit(3)
                //                    .lineLimit(3)
                //                    .multilineTextAlignment(.leading)
                
                Spacer()
                Button(action: {
                    self.isSheetShowing = true
                }) {
                    Image("ellipsis")
                        .resizable()
                        .frame(width: 20.0, height: 20.0)
                }.actionSheet(isPresented: $isSheetShowing) {
                    self.actionSheet
                }
                .foregroundColor(Color.red)
            }.modifier(PaddingModifier())
            
            Rectangle()
                .foregroundColor(Color.gray)
                .frame(height: 1.0)
            
            if (timeline.items.count == 1) {
                SingleImage(imageName: timeline.items[0])
                    .padding()
            } else if (timeline.items.count == 2) {
                TwoImage(firstImage: timeline.items[0], secondImage: timeline.items[1])
                    .padding()
            } else if (timeline.items.count == 3) {
                ThreeImage(firstImage: timeline.items[0], secondImage: timeline.items[1], thirdImage: timeline.items[2])
                    .padding()
            } else if (timeline.items.count == 4) {
                FourImage(firstImage: timeline.items[0], secondImage: timeline.items[1], thirdImage: timeline.items[2], fourthImage: timeline.items[3])
                    .padding()
            } else if (timeline.items.count > 4) {
                FourImage(firstImage: timeline.items[0], secondImage: timeline.items[1], thirdImage: timeline.items[2], fourthImage: timeline.items[3])
                    .padding()
            } else {
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(height: 100.0)
                    .padding()
            }
            
            Rectangle()
                .foregroundColor(Color.gray)
                .frame(height: 1.0)
            
            HStack {
                Button(action: {print("like")}) {
                    HStack {
                        Image("like").resizable().frame(width: 20, height: 20)
                        Text("\(timeline.like)")
                    }
                }
                
                Spacer()
                Button(action: {print("comment")}) {
                    HStack {
                        Image("comment").resizable().frame(width: 20, height: 20)
                        Text("\(timeline.comment)")
                    }
                }
                Spacer()
                Button(action: {print("share")}) {
                    HStack {
                        Image("share").resizable().frame(width: 20, height: 20)
                        Text("\(timeline.like)")
                    }
                }
            }.foregroundColor(Color.red)
                .padding()
        }.frame(height: 350.0)
            .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color.gray))
        
    }
}

#if DEBUG
struct TimelineCell_Previews : PreviewProvider {
    static var previews: some View {
        TimelineCell(timeline: testData[0])
    }
}
#endif
