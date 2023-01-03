//
//  Task.swift
//  GoodList
//
//  Created by Monil Gandhi on 15/01/21.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
