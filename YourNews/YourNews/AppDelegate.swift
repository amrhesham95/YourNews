//
//  AppDelegate.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // MARK: - Properties
  
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
  
  /// Coordinates app navigation.
  ///
  var appCoordinator: AppCoordinator?

  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    setupMainWindow()
    appCoordinator?.start()
    return true
  }
}

// MARK: - Initialization Methods
//
private extension AppDelegate {
  
  /// Sets up the main UIWindow instance.
  ///
  func setupMainWindow() {
    let window = UIWindow()
    window.makeKeyAndVisible()
    let navigationController = UINavigationController()
    appCoordinator = AppCoordinator(navigationController: navigationController)
//    window.rootViewController = FavoriteScreenViewController()
    window.rootViewController = appCoordinator?.navigationController // to be replaced with tab bar if implemented
    self.window = window
  }  
}
