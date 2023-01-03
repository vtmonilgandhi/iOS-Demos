/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import SafariServices
import MaterialComponents

class ArticlesViewController: UICollectionViewController {

  let appBar = MDCAppBar()
  let heroHeaderView = HeroHeaderView()
  let tabBar = MDCTabBar()

  let apiClient = NewsClient()
  var articles: [Article] = []
  var inProgressTask: Cancellable?

  override func viewDidLoad() {
    super.viewDidLoad()
    configureAppBar()
    configureTabBar()
    configureCollectionView()
    refreshContent()
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

}

// MARK: UI Configuration
extension ArticlesViewController {

  func configureCollectionView() {
    let cellNib = UINib(nibName: "ArticleCell", bundle: nil)
    collectionView?.register(cellNib, forCellWithReuseIdentifier: ArticleCell.cellID)
    collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
  }
  
  func configureAppBar() {
   
    appBar.headerViewController.layoutDelegate = self

    self.addChild(appBar.headerViewController)
    
    appBar.navigationBar.backgroundColor = .clear
    appBar.navigationBar.title = nil
    
    let headerView = appBar.headerViewController.headerView
    headerView.backgroundColor = .clear
    headerView.maximumHeight = HeroHeaderView.Constants.maxHeight
    headerView.minimumHeight = HeroHeaderView.Constants.minHeight
    
    heroHeaderView.frame = headerView.bounds
    headerView.insertSubview(heroHeaderView, at: 0)
    
    headerView.trackingScrollView = self.collectionView
    
    appBar.addSubviewsToParent()
  }

  func configureTabBar() {
 
    tabBar.itemAppearance = .titles
 
    tabBar.items = NewsSource.allValues.enumerated().map { index, source in
      return UITabBarItem(title: source.title, image: nil, tag: index)
    }
 
    tabBar.selectedItem = tabBar.items[0]
 
    tabBar.delegate = self
  
    appBar.headerStackView.bottomBar = tabBar
  }

  // MARK: UIScrollViewDelegate
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let headerView = appBar.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollDidScroll()
    }
  }
  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let headerView = appBar.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollDidEndDecelerating()
    }
  }
  
  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let headerView = appBar.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
    }
  }
  
  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let headerView = appBar.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollWillEndDragging(withVelocity: velocity,
                                               targetContentOffset: targetContentOffset)
    }
  }
}

// MARK: MDCTabBarDelegate
extension ArticlesViewController: MDCTabBarDelegate {
  
  func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
    refreshContent()
  }
}

// MARK: MDCFlexibleHeaderViewLayoutDelegate
extension ArticlesViewController: MDCFlexibleHeaderViewLayoutDelegate {
  
  public func flexibleHeaderViewController(_ flexibleHeaderViewController: MDCFlexibleHeaderViewController,
                                           flexibleHeaderViewFrameDidChange flexibleHeaderView: MDCFlexibleHeaderView) {
    heroHeaderView.update(withScrollPhasePercentage: flexibleHeaderView.scrollPhasePercentage)
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ArticlesViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.bounds.width - (ArticleCell.cellPadding * 2), height: ArticleCell.cellHeight)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: ArticleCell.cellPadding, left: ArticleCell.cellPadding, bottom: ArticleCell.cellPadding, right: ArticleCell.cellPadding)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return ArticleCell.cellPadding
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }

}

// MARK: UICollectionViewDataSource and Delegate
extension ArticlesViewController {

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return articles.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.cellID, for: indexPath) as? ArticleCell {
      cell.article = articles[indexPath.row]
      return cell
    } else {
      fatalError("Missing cell for indexPath: \(indexPath)")
    }
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let article = articles[indexPath.row]

    guard let url = article.articleURL else {
      return
    }

    let config = SFSafariViewController.Configuration()
    config.entersReaderIfAvailable = true
    let safariVC = SFSafariViewController(url: url, configuration: config)
    self.present(safariVC, animated: true, completion: nil)
  }

}

// MARK: Data
extension ArticlesViewController {

  func refreshContent() {
    guard inProgressTask == nil else {
      inProgressTask?.cancel()
      inProgressTask = nil
      return
    }
    
    guard let selectedItem = tabBar.selectedItem else {
      return
    }
    
    let source = NewsSource.allValues[selectedItem.tag]
    
    inProgressTask = apiClient.articles(forSource: source) { [weak self] (articles, error) in
      self?.inProgressTask = nil
      if let articles = articles {
        self?.articles = articles
        self?.collectionView?.reloadData()
      } else {
        self?.showError()
      }
    }
  }

  func showError() {
    
  }

}
