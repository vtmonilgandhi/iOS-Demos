//
//  Concentration.swift
//  Concentration
//
//  Created by Monil Gandhi on 4/20/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import Foundation

// Here we change Concentartion from class to struct
// So we have to change func chooseCard to mutating funch chooseCard
// Because strut don't allow to change self properties without mutating keyword
struct Concentration {
    private(set) var cards = [Card]()

    private var indexOneAndOnlyFacedUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFacedup }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFacedup = (index == newValue)
            }
        }
    }

    init(numbersOfPairsOfCards: Int) {
        assert(numbersOfPairsOfCards > 0, "Concentration.init(\(index) : you must have atleast one pair of cards")
        for _ in 0 ..< numbersOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
    }

    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at : \(index) : chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOneAndOnlyFacedUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedup = true
            } else {
                indexOneAndOnlyFacedUpCard = index
            }
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
