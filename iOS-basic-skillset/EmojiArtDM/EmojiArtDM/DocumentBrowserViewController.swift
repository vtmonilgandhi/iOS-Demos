//
//  DocumentBrowserViewController.swift
//  EmojiArtDM
//
//  Created by Monil Gandhi on 5/8/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit

class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        allowsPickingMultipleItems = false
        allowsDocumentCreation = false
        if UIDevice.current.userInterfaceIdiom == .pad {
            template = try? FileManager.default.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            ).appendingPathComponent("Untitled.emojiart")
            if template != nil {
                allowsDocumentCreation = FileManager.default.createFile(atPath: template!.path, contents: Data())
            }
        }
    }

    var template: URL?

    // MARK: UIDocumentBrowserViewControllerDelegate

    func documentBrowser(_: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        print("didRequestDocumentCreationWithHandle")
        importHandler(template, .copy)
    }

    func documentBrowser(_: UIDocumentBrowserViewController, didPickDocumentURLs documentURLs: [URL]) {
        print(" didPickDocumentURLs")
        guard let sourceURL = documentURLs.first else { return }
        presentDocument(at: sourceURL)
    }

    func documentBrowser(_: UIDocumentBrowserViewController, didImportDocumentAt _: URL, toDestinationURL destinationURL: URL) {
        print("didImportDocumentAt")
        presentDocument(at: destinationURL)
    }

    func documentBrowser(_: UIDocumentBrowserViewController, failedToImportDocumentAt _: URL, error _: Error?) {
        print("error")
    }

    // MARK: Document Presentation

    func presentDocument(at documentURL: URL) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let documentVC = storyBoard.instantiateViewController(withIdentifier: "DocumentMVC")
        if let emojiArtViewController = documentVC.contents as? EmojiArtViewController {
            emojiArtViewController.document = EmojiArtDocument(fileURL: documentURL)
        }
        present(documentVC, animated: true)
    }
}
