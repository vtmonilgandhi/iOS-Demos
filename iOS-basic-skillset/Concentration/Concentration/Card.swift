//
//  Card.swift
//  Concentration
//
//  Created by Monil Gandhi on 4/20/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int { return identifier }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    var isFacedup = false
    var isMatched = false
    private var identifier: Int

    private static var identiferFactory = 0

    init() {
        identifier = Card.getUniqueIdentifier()
    }

    private static func getUniqueIdentifier() -> Int {
        identiferFactory += 1
        return identiferFactory
    }
}
