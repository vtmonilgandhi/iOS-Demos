//
//  ViewController.swift
//  PhotoAlbum
//
//  Created by Monil Gandhi on 15/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var pageControl: UIPageControl!

    @IBOutlet var scrMain: UIScrollView!

    let arrImages = ["1", "2", "3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadScrollView()
    }

    func loadScrollView() {
        let pageCount: CGFloat = CGFloat(arrImages.count)

        scrMain.backgroundColor = UIColor.clear
        scrMain.delegate = self
        scrMain.isPagingEnabled = true
        scrMain.contentSize = CGSize(width: scrMain.frame.size.width * pageCount, height: scrMain.frame.size.height)
        scrMain.showsHorizontalScrollIndicator = false

        pageControl.numberOfPages = Int(pageCount)
        pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)

        for i in 0 ..< Int(pageCount) {
            print(scrMain.frame.size.width)
            let image = UIImageView(frame: CGRect(x: scrMain.frame.size.width * CGFloat(i), y: 0, width: scrMain.frame.size.width, height: scrMain.frame.size.height))
            image.image = UIImage(named: arrImages[i])!
            image.contentMode = UIViewContentMode.scaleAspectFit
            scrMain.addSubview(image)
        }
    }

    // MARK: Page tap action

    @objc func pageChanged() {
        let pageNumber = pageControl.currentPage
        var frame = scrMain.frame
        frame.origin.x = frame.size.width * CGFloat(pageNumber)
        frame.origin.y = 0
        scrMain.scrollRectToVisible(frame, animated: true)
    }
}

extension ViewController: UIScrollViewDelegate {

    // MARK: UIScrollView Delegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewWidth: CGFloat = scrollView.frame.size.width
        // content offset - tells by how much the scroll view has scrolled.
        let pageNumber = floor((scrollView.contentOffset.x - viewWidth / 50) / viewWidth) + 1
        pageControl.currentPage = Int(pageNumber)
    }
}
