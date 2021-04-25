//
//  AppCoordinator.swift
//  YourNews
//
//  Created by Amr Hesham on 25/04/2021.
//

import UIKit

// MARK: - AppCoordinator
//
class AppCoordinator {
  
  //    private let tabBarController: MainTabBarController
  
  private var isLoggedIn: Bool?
  
  // MARK: - Properties
  
  let navigationController: UINavigationController
  
  // MARK: - init
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  //  init(tabBarController: MainTabBarController) {
  //      self.navigationController = UINavigationController()
  //      self.tabBarController = tabBarController
  //  }
  // MARK: - Start
  
  func start() {
    
    guard let defaultFilter = ServiceLocator.defaultFilter else {
      showOnboardingViewController()
      return
    }
    showNewsViewController()
  }
}

// MARK: - Coordination Helpers
//
extension AppCoordinator {
  
  /// Show OnboardingViewController
  ///
  func showOnboardingViewController() {
    let viewController = OnboardingViewController(viewModel: OnboardingViewModel())
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
    //        tabBarController.present(viewController, animated: isAnimated)
  }
  
  /// Show NewsViewController.
  ///
  func showNewsViewController() {
    let viewController = NewsViewController()
    navigationController.setViewControllers([viewController], animated: true)
  }
}

