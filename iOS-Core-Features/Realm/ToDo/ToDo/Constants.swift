//
//  Constants.swift
//  ToDo
//
//  Created by Monil.Gandhi on 25/10/18.
//  Copyright © 2018 Monil.Gandhi. All rights reserved.
//

import Foundation
struct Constants {
  
    static let MY_INSTANCE_ADDRESS = "ghostytodo.us1a.cloud.realm.io"
    static let AUTH_URL  = URL(string: "https://\(MY_INSTANCE_ADDRESS)")!
    static let REALM_URL = URL(string: "realms://\(MY_INSTANCE_ADDRESS)/ToDo")!
}
