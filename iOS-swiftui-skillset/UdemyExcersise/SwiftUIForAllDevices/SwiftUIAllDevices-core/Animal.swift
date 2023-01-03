//
//  Animal.swift
//  SwiftUIForAllDevices
//
//  Created by Mohammad Azam on 9/18/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation

struct Animal: Hashable {
    let name: String
    let description: String
    let image: String
}

extension Animal {
    
    static var placeholder: Animal {
        return Animal(name: "", description: "", image: "")
    }
    
}
