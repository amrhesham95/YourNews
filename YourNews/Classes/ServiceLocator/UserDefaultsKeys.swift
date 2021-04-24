//
//  UserDefaultsKeys.swift
//  YourNews
//
//  Created by Amr Hesham on 25/04/2021.
//

import Foundation

// MARK: - UserDefaultsKeys
//
enum UserDefaultsKeys: String, CaseIterable {
  
  /// Current user codable value of `NewsFilter`
  case filter
  
  /// True if the app was launched and not the first time.
  case launchedBefore
  
}
