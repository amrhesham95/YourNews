//
//  NavigationScrollBehavior.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import UIKit

// MARK: - NavigationScrollBehavior
//
class NavigationScrollBehavior {
  
  var tintColor = UIColor.red
  var backgroundColor = UIColor.white
  private var defaultHeight = CGFloat(200)
  
  private weak var navController: UINavigationController?
  
  init(_ navController: UINavigationController?) {
    self.navController = navController
    
    navController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navController?.navigationBar.shadowImage = UIImage()
    navController?.navigationBar.isTranslucent = true
    navController?.navigationBar.prefersLargeTitles = false
  }
  
  /// Start offset updating; Should be called to update data for `.zero` offset.
  ///
  func updateInitialOffset() {
    updateViewForOffset(.zero)
  }
  
  /// Update default height with optionally respect to safe insets
  ///
  func updateHeight(_ newValue: CGFloat, shouldRespectSafeInsets: Bool = false) {
    var height = newValue
    
    if shouldRespectSafeInsets {
      height -= topSafeHeight
    }
    
    defaultHeight = max(height, .zero)
  }
  
  /// Called for scroll update
  ///
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = max(min(1, scrollView.contentOffset.y / defaultHeight), .zero)
    updateViewForOffset(offset)
  }
  
  /// Returns navigation bar height plus top safe area insets
  ///
  private var topSafeHeight: CGFloat {
    let topSafeHeight = navController?.view.safeAreaInsets.top ?? .zero
    let barHeight = navController?.navigationBar.bounds.height ?? .zero
    return topSafeHeight + barHeight
  }
  
  /// Update view for y offset
  ///
  private func updateViewForOffset(_ offset: CGFloat) {
    let backgroundColor = self.backgroundColor.withAlphaComponent(offset)
    navController?.navigationBar.backgroundColor = backgroundColor
  }
}
