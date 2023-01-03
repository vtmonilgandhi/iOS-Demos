//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Monil Gandhi on 4/24/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    var description: String { return "\(rank)\(suit)" }

    var suit: Suit
    var rank: Rank

    enum Suit: String, CustomStringConvertible {
        case spades = "♠️"
        case hearts = "❤️"
        case clubs = "♣️"
        case diamonds = "♦️"

        static var all = [Suit.spades, .hearts, .diamonds, .clubs]

        var description: String { return rawValue }
    }

    enum Rank: CustomStringConvertible {
        case ace
        case face(String)
        case numeric(Int)

        var order: Int {
            switch self {
            case .ace: return 1
            case let .numeric(pips): return pips
            case let .face(kind) where kind == "J": return 11
            case let .face(kind) where kind == "Q": return 12
            case let .face(kind) where kind == "K": return 13
            default: return 0
            }
        }

        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2 ... 10 {
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"), .face("Q"), .face("K")]
            return allRanks
        }

        var description: String {
            switch self {
            case .ace: return "A"
            case let .numeric(pips): return String(pips)
            case let .face(kind): return kind
            }
        }
    }
}
