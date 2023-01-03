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

class HeroHeaderView: UIView {
  
  struct Constants {
    static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    static let tabBarHeight: CGFloat = 48.0
    static let minHeight: CGFloat = 44 + statusBarHeight + tabBarHeight
    static let maxHeight: CGFloat = 400.0
  }

  
  // MARK: Properties
  
  let imageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "img-hero"))
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = NSLocalizedString("News Ink", comment: "")
    label.textAlignment = .center
    label.textColor = .white
    label.shadowOffset = CGSize(width: 1, height: 1)
    label.shadowColor = .darkGray
    return label
  }()
  
  // MARK: Init
  
  init() {
    super.init(frame: .zero)
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
    clipsToBounds = true
    configureView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: View
  
  func configureView() {
    backgroundColor = .darkGray
    addSubview(imageView)
    addSubview(titleLabel)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.frame = bounds
    titleLabel.frame = CGRect(
      x: 0,
      y: Constants.statusBarHeight,
      width: frame.width,
      height: frame.height - Constants.statusBarHeight - Constants.tabBarHeight)
  }

  
  func update(withScrollPhasePercentage scrollPhasePercentage: CGFloat) {
   
    let imageAlpha = min(scrollPhasePercentage.scaled(from: 0...0.8, to: 0...1), 1.0)
    imageView.alpha = imageAlpha
    
    let fontSize = scrollPhasePercentage.scaled(from: 0...1, to: 22.0...60.0)
    let font = UIFont(name: "CourierNewPS-BoldMT", size: fontSize)
    titleLabel.font = font
  }
}

// MARK: Number Utilities - Based on code from https://github.com/raizlabs/swiftilities
extension FloatingPoint {
  
  public func scaled(from source: ClosedRange<Self>, to destination: ClosedRange<Self>, clamped: Bool = false, reversed: Bool = false) -> Self {
    let destinationStart = reversed ? destination.upperBound : destination.lowerBound
    let destinationEnd = reversed ? destination.lowerBound : destination.upperBound
    
    // these are broken up to speed up compile time
    let selfMinusLower = self - source.lowerBound
    let sourceUpperMinusLower = source.upperBound - source.lowerBound
    let destinationUpperMinusLower = destinationEnd - destinationStart
    var result = (selfMinusLower / sourceUpperMinusLower) * destinationUpperMinusLower + destinationStart
    if clamped {
      result = result.clamped(to: destination)
    }
    return result
  }
  
}

public extension Comparable {
  
  func clamped(to range: ClosedRange<Self>) -> Self {
    return clamped(min: range.lowerBound, max: range.upperBound)
  }
  
  func clamped(min lower: Self, max upper: Self) -> Self {
    return min(max(self, lower), upper)
  }
  
}
