//
//  AppDelegate.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // MARK: - properties
  
  /// AppDelegate's Instance
  ///
  static var shared: AppDelegate {
    guard let appInstance = UIApplication.shared.delegate as? AppDelegate else {
      fatalError()
    }
    return appInstance
  }
  
  /// Main Window
  ///
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }
}

