//
//  ViewController.swift
//  Concentration
//
//  Created by Monil Gandhi on 4/20/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    // MARK: - Utilites

    private lazy var game = Concentration(numbersOfPairsOfCards: numbersOfPairsOfCards)

    var numbersOfPairsOfCards: Int {
        return (visibleCardButtions.count + 1) / 2
    }

    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }

    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }

    private var emojiChoices = "👻🎃🍎😸"

    private var emoji = [Card: String]()

    private var visibleCardButtions: [UIButton]! {
        return cardButtons?.filter { !$0.superview!.isHidden }
    }

    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] =
            [
                .strokeWidth: 5.0,
                .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            ]
        let attributedString = NSAttributedString(
            string: traitCollection.verticalSizeClass == .compact ? "Flips\n\(flipCount)" : "Flips:\(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }

    // MARK: - Outlets

    @IBOutlet private var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }

    @IBOutlet private var cardButtons: [UIButton]!

    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumbers = visibleCardButtions.index(of: sender) {
            game.chooseCard(at: cardNumbers)
            updateViewFromModel()
        } else {
            print("chossen card was not in card button")
        }
    }

    // MARK: - viewcontroller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }

    private func updateViewFromModel() {
        if visibleCardButtions != nil {
            for index in visibleCardButtions.indices {
                let button = visibleCardButtions[index]
                let card = game.cards[index]
                if card.isFacedup {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                }
            }
        }
    }

    private func emoji(for card: Card) -> String {
        let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
