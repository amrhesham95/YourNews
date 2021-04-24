//
//  UserDefaultsService.swift
//  YourNews
//
//  Created by Amr Hesham on 25/04/2021.
//

import Foundation

protocol UserDefaultsService {
  
  /// Returns the Object (if any) associated with the specified UserDefaultsKeys.
  ///
  func object<T>(forKey key: UserDefaultsKeys) -> T?
  
  /// Stores the UserDefaultsKeys/Value Pair.
  ///
  func set<T>(_ value: T?, forKey key: UserDefaultsKeys)
  
  /// Get Codable object into UserDefaults
  ///
  func codableObject<T: Codable>(forKey key: UserDefaultsKeys) -> T?
  
  /// Set Codable object into UserDefaults
  ///
  func setCodable<T: Codable>(_ value: T?, forKey key: UserDefaultsKeys)
  
  /// Nukes any object associated with the specified UserDefaultsKeys.
  ///
  func removeObject(forKey key: UserDefaultsKeys)
  
  /// Indicates if there's an entry for the specified UserDefaultsKeys.
  ///
  func containsObject(forKey key: UserDefaultsKeys) -> Bool
  
  /// Subscript Accessible via our new UserDefaultsKeys type!
  ///
  subscript<T>(key: UserDefaultsKeys) -> T? { get }
  
  /// Subscript: "Type Inference Fallback". To be used whenever the type cannot be automatically inferred!
  ///
  subscript(key: UserDefaultsKeys) -> Any? { get }
  
}

extension UserDefaultsService {
  
  /// Set Codable object into UserDefaults
  ///
  func setCodable<T: Codable>(_ value: T?, forKey key: UserDefaultsKeys) {
    
    let jsonData = try? JSONEncoder().encode(value)
    
    set(jsonData, forKey: key)
  }
  
  /// Get Codable object into UserDefaults
  ///
  func codableObject<T: Codable>(forKey key: UserDefaultsKeys) -> T? {
    
    guard let result: Data = object(forKey: key) else {
      return nil
    }
    
    return try? JSONDecoder().decode(T.self, from: result)
  }
}
