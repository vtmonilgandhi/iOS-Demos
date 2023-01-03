//
//  Timeline.swift
//  ChitChat
//
//  Created by Gandhi Monil on 23/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct Timeline: Identifiable {
    var id = UUID()
    var name: String
    var like: String
    var comment: String
    var items: [String]
    var imageName: String { return name }
}

#if DEBUG
let testData = [
    Timeline(name: "Sai Kambampati",
             like: "10",
             comment: "10",
             items: [
                "Sai Kambampati",
                "Simon Ng",
                "profile"]),
    
    Timeline(name: "Simon Ng",
             like: "10",
             comment: "10",
             items: []),
    
    Timeline(name: "Gabriel Theodoropoulos",
             like: "10",
             comment: "10",
             items: [
                "Sai Kambampati",
                "Simon Ng",
                "profile",
                "thomas_edison",
                "leonardo_da_vinci"]),
    
    Timeline(name: "Andrew Jaffee",
             like: "10",
             comment: "10",
             items: [
                "Simon Ng",
                "profile",
                "thomas_edison",
                "steve_jobs"]),
    
    Timeline(name: "Athena Lam",
             like: "10",
             comment: "10",
             items: [
                "thomas_edison",
                "leonardo_da_vinci",
                "steve_jobs"]),
    
    Timeline(name: "Alfian Losari",
             like: "10",
             comment: "10",
             items: [
                "steve_jobs"]),
    
    Timeline(name: "Lawrence Tan",
             like: "10",
             comment: "10",
             items: [
                "Sai Kambampati",
                "Simon Ng",
                "profile",
                "thomas_edison",
                "leonardo_da_vinci",
                "steve_jobs"]),
    
    Timeline(name: "Kelvin Tan",
             like: "10",
             comment: "10",
             items: [
                "leonardo_da_vinci",
                "steve_jobs"]),
]
#endif
