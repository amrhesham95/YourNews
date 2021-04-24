//
//  ServiceLocator.swift
//  YourNews
//
//  Created by Amr Hesham on 24/04/2021.
//

import Foundation

/// Provides global dependencies.
///
final class ServiceLocator {
  
  // MARK: - Private properties
  
  /// User Defaults
  ///
  private static var _defaults: UserDefaultsService = UserDefaults.standard
  
  /// News Store
  ///
  private static var _store: NewsStoreProtocol = NewsStore(remote: NewsRemote(network: NetworkManager()))
  
  private static var _defaultFilter: NewsFilter? {
    get {
      return ServiceLocator.defaults.codableObject(forKey: .filter)
    }
    set {
      ServiceLocator.defaults.setCodable(newValue, forKey: .filter)
      ///
      //          let account: [String: Account?] = ["account": defaultAccount]
      //          NotificationCenter.default.post(name: .defaultAccountWasUpdated, object: defaultAccount, userInfo: account as [AnyHashable: Any])
    }
  }
  
  
  // MARK: - Getters
  
  /// Provides the access point to the user defaults.
  static var defaults: UserDefaultsService {
    return _defaults
  }
  
  /// Provides the access point to the news store.
  static var newsStore: NewsStoreProtocol {
    return _store
  }
  
  /// Provides the access point to the default Filter
  static var defaultFilter: NewsFilter {
    return _defaultFilter ?? NewsFilter()
  }
}

/// The setters declared in this extension are meant to be used only from the test bundle
extension ServiceLocator {
  static func setNewsStore(_ mock: NewsStoreProtocol) {
    guard isRunningTests() else {
      return
    }
    _store = mock
  }
}

// MARK: - Testing checker
private extension ServiceLocator {
  static func isRunningTests() -> Bool {
    return NSClassFromString("XCTestCase") != nil
  }
}

