//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by CS193p Instructor.
//  Copyright © 2017 CS193p Instructor. All rights reserved.
//

import Foundation

struct EmojiArt: Codable {
    var url: URL
    var emojis = [EmojiInfo]()

    struct EmojiInfo: Codable {
        let x: Int
        let y: Int
        let text: String
        let size: Int
    }

    init?(json: Data) { // take some JSON and try to init an EmojiArt from it
        if let newValue = try? JSONDecoder().decode(EmojiArt.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }

    var json: Data? { // return this EmojiArt as a JSON data
        return try? JSONEncoder().encode(self)
    }

    init(url: URL, emojis: [EmojiInfo]) {
        self.url = url
        self.emojis = emojis
    }
}
