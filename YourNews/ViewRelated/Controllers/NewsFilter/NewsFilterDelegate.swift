//
//  NewsFilterDelegate.swift
//  YourNews
//
//  Created by Amr Hesham on 24/04/2021.
//

import UIKit

// MARK: - NewsFilterDelegate - Delegate when finish data filtering
//
protocol NewsFilterDelegate: class {
  
  /// When search button tapped
  ///
  func notificationsFilter(viewController: NewsFilterViewController, didTappedSearch button: UIButton, with result: NewsFilter)
}
