//
//  Items.swift
//  ToDo
//
//  Created by Monil.Gandhi on 25/10/18.
//  Copyright © 2018 Monil.Gandhi. All rights reserved.
//

import RealmSwift

class Item: Object {
    
    @objc dynamic var itemId: String = UUID().uuidString
    @objc dynamic var body: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var assignee: String = ""
    @objc dynamic var timestamp: Date = Date()
    
    override static func primaryKey() -> String? {
        return "itemId"
    }
    
}
