//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by Monil Gandhi on 5/2/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit

protocol EmojiArtViewDelegate: class {
    func emojiArtViewDidChange(_ sender: EmojiArtView)
}

class EmojiArtView: UIView {

    // MARK: - Delegation

    weak var delegate: EmojiArtViewDelegate?
    var backgroundImage: UIImage? { didSet { setNeedsDisplay() } }

    override func draw(_: CGRect) {
        backgroundImage?.draw(in: bounds)
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addInteraction(UIDropInteraction(delegate: self))
    }

    func addLabel(with attributedString: NSAttributedString, centeredAt point: CGPoint) {
        let label = UILabel()
        label.backgroundColor = .clear
        label.attributedText = attributedString
        label.sizeToFit()
        label.center = point
        addEmojiArtGestureRecognizers(to: label)
        addSubview(label)
    }
}

// MARK: - UIDropInteractionDelegate

extension EmojiArtView: UIDropInteractionDelegate {
    func dropInteraction(_: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSAttributedString.self)
    }

    func dropInteraction(_: UIDropInteraction, sessionDidUpdate _: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: NSAttributedString.self) { providers in
            let dropPoint = session.location(in: self)
            for attributedString in providers as? [NSAttributedString] ?? [] {
                self.addLabel(with: attributedString, centeredAt: dropPoint)
                self.delegate?.emojiArtViewDidChange(self) // ADDED AFTER L14
            }
        }
    }
}
