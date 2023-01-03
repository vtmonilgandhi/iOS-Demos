//
//  DocumentInfoViewController.swift
//  EmojiArtDM
//
//  Created by Monil Gandhi on 5/9/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit

class DocumentInfoViewController: UIViewController {

    // MARK: - Storyboard

    @IBAction func done() {
        presentingViewController?.dismiss(animated: true)
    }

    @IBOutlet var returnToDocumentButton: UIButton!
    @IBOutlet var topLevelView: UIStackView!
    @IBOutlet var thumbnailAspectRatio: NSLayoutConstraint!

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var createdLabel: UILabel!

    // MARK: - Model

    var document: EmojiArtDocument? {
        didSet { updateUI() }
    }

    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let fittedSize = topLevelView?.sizeThatFits(UILayoutFittingCompressedSize) {
            preferredContentSize = CGSize(width: fittedSize.width + 30, height: fittedSize.height + 30)
        }
    }

    // MARK: - UI Updating

    private let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    private func updateUI() {
        if sizeLabel != nil, createdLabel != nil,
            let url = document?.fileURL,
            let attributes = try? FileManager.default.attributesOfItem(atPath: url.path) {
            sizeLabel.text = "\(attributes[.size] ?? 0) bytes"
            if let created = attributes[.creationDate] as? Date {
                createdLabel.text = shortDateFormatter.string(from: created)
            }
        }
        if thumbnailImageView != nil, thumbnailAspectRatio != nil, let thumbnail = document?.thumbnail {
            thumbnailImageView.image = thumbnail
            thumbnailImageView.removeConstraint(thumbnailAspectRatio)
            thumbnailAspectRatio = NSLayoutConstraint(
                item: thumbnailImageView,
                attribute: .width,
                relatedBy: .equal,
                toItem: thumbnailImageView,
                attribute: .height,
                multiplier: thumbnail.size.width / thumbnail.size.height,
                constant: 0
            )
            thumbnailImageView.addConstraint(thumbnailAspectRatio)
        }

        if presentationController is UIPopoverPresentationController {
            thumbnailImageView?.isHidden = true
            returnToDocumentButton?.isHidden = true
            view.backgroundColor = .clear
        }
    }
}
