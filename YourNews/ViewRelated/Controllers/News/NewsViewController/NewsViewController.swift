//
//  NewsViewController.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

import UIKit

class NewsViewController: UIViewController {
  
  
  // MARK: - Outlets
  
  @IBOutlet weak var contentView: UIView!
  
  // MARK: - Properties
  
  /// MyTicketsListSelectorDataSource
  ///
  private(set) lazy var newsSearchCommand: NewsSearchCommand = {
    return NewsSearchCommand(onSelectSearchResult: handleOnSelectArticle(article:))
  }()
  
  /// Search view controller for all departments
  ///
  lazy var searchViewController: SearchViewController = {
    return SearchViewController(
      command: newsSearchCommand,
      cellType: NewsCell.self,
      cellSeparator: .singleLine
    )
  }()
  
  
  
  // MARK: - ViewLifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureListViewController()
    configureOnFilterTapped()
  }
}

// MARK: - View's Configuration
//
private extension NewsViewController {
  
  func configureOnFilterTapped() {
    searchViewController.configureOnFilterTapped(completion: presentFilter)
  }
  
  /// Apply configuration for list view controller
  ///
  func configureListViewController() {
    addChildViewController(searchViewController,
                           parentView: view)
  }
}

// MARK: - Private handlers
//
private extension NewsViewController {
  
  func handleOnSelectArticle(article: News) {
    WebviewHelper.launch(article.url, with: self)
  }
  
  func presentFilter() {
    let filterViewController = NewsFilterViewController(delegate: self)
    present(filterViewController, animated: true)
  }
}

// MARK: - News filter delegate
//
extension NewsViewController: NewsFilterDelegate {
  func newsFilter(viewController: NewsFilterViewController, didTappedSearch button: UIButton, with result: NewsFilter) {
    viewController.dismiss(animated: true)
    newsSearchCommand.updateFilter(with: result)
  }
}
