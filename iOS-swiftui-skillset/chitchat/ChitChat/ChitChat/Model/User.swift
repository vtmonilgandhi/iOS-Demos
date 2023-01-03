//
//  User.swift
//  ChitChat
//
//  Created by Gandhi Monil on 26/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct User: Codable {
    var name: String?
    var email: String?
    var phone: String?
    var birthday: String?
    var homeTown: String?
    var userImage: String? { return name }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case phone = "phone"
        case birthday = "birthday"
        case homeTown = "city"
    }
    
//    public init(name: String, email: String, phone: String, birthday: String, homeTown: String) {
//        self.name = name
//        self.email = email
//        self.phone = phone
//        self.birthday = birthday
//        self.homeTown = homeTown
//    }
    
    //    public typealias Todos = [Todo]
}


#if DEBUG
/*
 Timeline(name: "Sai Kambampati",
 like: "10",
 comment: "10",
 items: [
 "Sai Kambampati",
 "Simon Ng",
 "profile"])
 */
let userData = User(name: "Gabriel Theodoropoulos",
                    email: "demo@gmail.com",
                    phone: "9428363728",
                    birthday: "28/01/1997",
                    homeTown: "Surat")
#endif
