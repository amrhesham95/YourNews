//
//  UserDefaults+UserDefaultsService.swift
//  YourNews
//
//  Created by Amr Hesham on 25/04/2021.
//

import Foundation

// MARK: - Convenience Methods
//
extension UserDefaults: UserDefaultsService {
  
  /// Returns the Object (if any) associated with the specified UserDefaultsKeys.
  ///
  func object<T>(forKey key: UserDefaultsKeys) -> T? {
    return value(forKey: key.rawValue) as? T
  }
  
  /// Stores the UserDefaultsKeys/Value Pair.
  ///
  func set<T>(_ value: T?, forKey key: UserDefaultsKeys) {
    set(value, forKey: key.rawValue)
  }
  
  /// Nukes any object associated with the specified UserDefaultsKeys.
  ///
  func removeObject(forKey key: UserDefaultsKeys) {
    removeObject(forKey: key.rawValue)
  }
  
  /// Indicates if there's an entry for the specified UserDefaultsKeys.
  ///
  func containsObject(forKey key: UserDefaultsKeys) -> Bool {
    return value(forKey: key.rawValue) != nil
  }
  
  /// Subscript Accessible via our new UserDefaultsKeys type!
  ///
  subscript<T>(key: UserDefaultsKeys) -> T? {
    get {
      return value(forKey: key.rawValue) as? T
    }
    set {
      set(newValue, forKey: key.rawValue)
    }
  }
  
  /// Subscript: "Type Inference Fallback". To be used whenever the type cannot be automatically inferred!
  ///
  subscript(key: UserDefaultsKeys) -> Any? {
    get {
      return value(forKey: key.rawValue)
    }
    set {
      set(newValue, forKey: key.rawValue)
    }
  }
}
