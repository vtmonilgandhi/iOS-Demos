//
//  ContentView.swift
//  Project1SwiftUI
//
//  Created by Gandhi Monil on 04/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import Combine
import SwiftUI

class DataSource: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    var pictures = [String]()
    
    init() {
        let fm = FileManager.default
        if let path = Bundle.main.resourcePath, let items = try? fm.contentsOfDirectory(atPath: path) {
            for item in items {
                if item.hasPrefix("nssl") {
                    pictures.append(item)
                }
            }
        }
        didChange.send(())
    }
}

struct DetailView: View {
    @State private var hidesNavigationBar = false
    var selectedImage: UIImage
    var name: String
    
    var body: some View {
        //        let img = UIImage(named: selectedImage)!
        Image(uiImage: selectedImage)
            .resizable()
            .aspectRatio(1024/768, contentMode: .fit)
            .navigationBarTitle(Text(name), displayMode: .inline)
            .navigationBarHidden(hidesNavigationBar)
            .tapAction {
                // image was tapped
                self.hidesNavigationBar.toggle()
        }
    }
}

struct ContentView : View {
    @ObjectBinding var dataSource = DataSource()
    
    var body: some View {
        NavigationView {
            List(dataSource.pictures.identified(by: \.self)) { picture in
                NavigationLink(destination: DetailView(selectedImage: UIImage(named: picture)!, name: picture)) {
                    Text(picture)
                }
            }.navigationBarTitle(Text("Strom Viewer"))
        }
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
