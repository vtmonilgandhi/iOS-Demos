//
//  Project.swift
//  ToDo
//
//  Created by Monil.Gandhi on 25/10/18.
//  Copyright © 2018 Monil.Gandhi. All rights reserved.
//

import RealmSwift

class Project: Object {
    
    @objc dynamic var projectId: String = UUID().uuidString
    @objc dynamic var owner: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var timestamp: Date = Date()
    
    let items = List<Item>()
    
    override static func primaryKey() -> String? {
        return "projectId"
    }
    
}
