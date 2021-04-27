//
//  MainTabBarController.swift
//  YourNews
//
//  Created by Amr Hesham on 27/04/2021.
//

import UIKit

// MARK: - MainTabBarController
//
class MainTabBarController: UITabBarController {
  
  // MARK: - Properties
  
  private let newsViewController: NewsViewController = {
    return NewsViewController()
  }()
  
  private let favoritesViewController: FavoriteScreenViewController = {
    return FavoriteScreenViewController()
  }()
  
  func showNewsScreen() {
    configureTabViewControllers()
    configureTabBarItems()
  }


  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTabViewControllers()
    configureTabBarItems()
  }
}

// MARK: - Helpers
//
private extension MainTabBarController {
  
  /// Configure tab view controllers,
  /// used at view initialization to setup the visible view controllers.
  ///
  func configureTabViewControllers() {
    viewControllers?.removeAll()
    viewControllers = {
      var controllers = viewControllers ?? []
      
      let newsTabIndex = AppTab.news.visibleIndex()
      controllers.insert(UINavigationController(rootViewController: newsViewController), at: newsTabIndex)
      
      let favoritesTabIndex = AppTab.favorites.visibleIndex()
      controllers.insert(UINavigationController(rootViewController: favoritesViewController), at: favoritesTabIndex)

      
      return controllers
    }()
  }
  
  /// Create TabBar items for visible items
  ///
  func configureTabBarItems() {
   
    let newsTab = UITabBarItem(title: "News".localized, image: Asset.homeTabIcon.image, selectedImage: nil)
    newsViewController.navigationController?.tabBarItem = newsTab
    
    let favoritesTab = UITabBarItem(title: "Favorite".localized, image: Asset.favoriteTabIcon.image, selectedImage: nil)
    favoritesViewController.navigationController?.tabBarItem = favoritesTab
  }
}
