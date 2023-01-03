//
//  EmojiArtDocument.swift
//  EmojiArtDM
//
//  Created by Monil Gandhi on 5/8/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit

class EmojiArtDocument: UIDocument {
    var emojiArt: EmojiArt? // the Model for this Document

    var thumbnail: UIImage? // thumbnail image for this Document

    override func contents(forType _: String) throws -> Any {
        return emojiArt?.json ?? Data()
    }

    override func load(fromContents contents: Any, ofType _: String?) throws {
        if let json = contents as? Data {
            emojiArt = EmojiArt(json: json)
        }
    }

    override func fileAttributesToWrite(to url: URL, for saveOperation: UIDocumentSaveOperation) throws -> [AnyHashable: Any] {
        var attributes = try super.fileAttributesToWrite(to: url, for: saveOperation)
        if let thumbnail = self.thumbnail {
            attributes[URLResourceKey.thumbnailDictionaryKey] = [URLThumbnailDictionaryItem.NSThumbnail1024x1024SizeKey: thumbnail]
        }
        return attributes
    }
}
