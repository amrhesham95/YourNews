//
//  UIViewController+Helpers.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import UIKit

/// UIViewController Helpers
///
extension UIViewController {
  
  /// Returns the default nibName: Matches the classname (expressed as a String!)
  ///
  class var nibName: String {
    return classNameWithoutNamespaces
  }
  
  /// Removes the text of the navigation bar back button in the next view controller of the navigation stack.
  ///
  func removeNavigationBackBarButtonText() {
    navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: nil, action: nil)
  }
  
  /// Show the X close button or a custom close button with title on the left bar button item position
  ///
  func addCloseNavigationBarButton(title: String? = nil, target: Any? = self, action: Selector? = #selector(dismissVC)) {
    if let title = title {
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
    }
    else {
      navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: target, action: action)
    }
  }
  
  /// Add child view controller to current view controller. Will be added in parent view controller.
  ///
  func addChildViewController(_ viewController: UIViewController, parentView: UIView) {
    addChild(viewController)
    viewController.view.addAndFixInView(parentView)
    viewController.didMove(toParent: self)
  }
}

/// Private methods
///
private extension UIViewController {
  
  /// Dismiss method
  ///
  @objc func dismissVC() {
    dismiss(animated: true, completion: nil)
  }
}
