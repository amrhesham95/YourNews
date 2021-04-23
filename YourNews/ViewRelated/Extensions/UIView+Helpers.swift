//
//  UIView+Helpers.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation
import UIKit

// MARK: - UIView + Helpers
//
extension UIView {
  
  /// Corner radius
  var cornerRadius: CGFloat {
    get {
      self.layer.cornerRadius
    }
    
    set {
      self.layer.masksToBounds = true
      self.layer.cornerRadius = newValue
    }
  }
  
  /// Add and fix `UIView` on `ContainerView`
  ///
  func addAndFixInView(_ container: UIView, space: CGFloat = .zero) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.frame = container.frame
    container.addSubview(self)
    
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: space),
      NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: -space),
      NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: space),
      NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: -space)
    ]
    
    constraints.forEach { $0.priority = .defaultHigh }
    NSLayoutConstraint.activate(constraints)
  }
  
  /// Add gradient to UIView `Layer`, removes the first `CAGradientLayer` if exists.
  func addGradientWith(colors: [UIColor?]) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = colors.compactMap { $0?.cgColor }
    gradientLayer.startPoint = CGPoint(x: 0, y: 1)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    gradientLayer.frame.size = self.frame.size
    gradientLayer.frame.origin = CGPoint.zero
    self.layer.masksToBounds = true
    (self.layer.sublayers?.first as? CAGradientLayer)?.removeFromSuperlayer()
    self.layer.insertSublayer(gradientLayer, at: 0)
  }
}

/// UIView Layoutconstraints helpers
///
extension UIView {
  
  /// Apply padding for view to container view
  ///
  func padding(
    topSpace: CGFloat = .zero,
    buttomSpace: CGFloat = .zero,
    leadingSpace: CGFloat = .zero,
    trailingSpace: CGFloat = .zero
  ) {
    
    guard let container = superview else {
      fatalError("\(self) must be in a view to add padding!")
    }
    
    translatesAutoresizingMaskIntoConstraints = false
    
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: leadingSpace),
      NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: -trailingSpace),
      NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: topSpace),
      NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: -buttomSpace)
    ]
    
    constraints.forEach { $0.priority = .defaultHigh }
    NSLayoutConstraint.activate(constraints)
  }
  
  /// Make aspect ratio to uiview element
  /// - Parameter ratio: Ratio for view, for example 1/1 will be 1 to 1
  /// - Returns: `NSLayoutConstraint` to activate or set piriorty
  ///
  func aspectRatio(_ ratio: CGFloat) -> NSLayoutConstraint {
    return NSLayoutConstraint(
      item: self,
      attribute: .height,
      relatedBy: .equal,
      toItem: self,
      attribute: .width,
      multiplier: ratio,
      constant: .zero
    )
  }
}

/// UIView Class Methods
///
extension UIView {
  
  /// Returns the Nib associated with the received: It's filename is expected to match the Class Name
  ///
  class func loadNib() -> UINib {
    return UINib(nibName: classNameWithoutNamespaces, bundle: nil)
  }
  
  /// Returns the first Object contained within the nib with a name whose name matches with the receiver's type.
  /// Note: On error this method is expected to break, by design!
  ///
  // swiftlint:disable force_cast
  class func instantiateFromNib<T>() -> T {
    
    return loadNib().instantiate(withOwner: nil, options: nil).first as! T
  }
}

/// UIView Extension Methods
///
extension UIView {
  
  /// Returns the first Subview of the specified Type (if any).
  ///
  func firstSubview<T: UIView>(ofType type: T.Type) -> T? {
    for subview in subviews {
      guard let target = (subview as? T) ?? subview.firstSubview(ofType: type) else {
        continue
      }
      
      return target
    }
    
    return nil
  }
}

// MARK: - Metics Helpers
//
extension UIView {
  
  /// Apply default height
  ///
  func applyDefaultHeight() {
    let heightConstraint = heightAnchor.constraint(equalToConstant: UISettings.defaultHeight)
    heightConstraint.priority = .defaultHigh
    heightConstraint.isActive = true
  }
}

