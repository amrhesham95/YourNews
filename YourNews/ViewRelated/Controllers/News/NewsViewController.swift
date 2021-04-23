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
    
    // MARK: - Proeprties
    
    /// Search view controller for all departments
    ///
    lazy var searchViewController: SearchViewController = {
      return SearchViewController(
        command: NewsSearchCommand(onSelectSearchResult: handleOnSelectArticle(article:)),
        cellType: BasicTableViewCell.self,
        cellSeparator: .singleLine
      )
    }()
    

    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      configureListViewController()
    }
  }

  // MARK: - View's Configuration
  //
  private extension NewsViewController {
    
    /// Apply configuration for list view controller
    ///
    func configureListViewController() {
      addChildViewController(searchViewController,
                             parentView: contentView)
    }
  }

  // MARK: - Private handlers
  //
  private extension NewsViewController {
    
    func handleOnSelectArticle(article: News) {
      print(article)
    }
}

 //MARK: - UITableViewCell+SearchResultCell

extension BasicTableViewCell: SearchResultCell {

  typealias SearchModel = News

  static func register(for tableView: UITableView) {
    tableView.register(self, forCellReuseIdentifier: self.classNameWithoutNamespaces)
  }

  func configureCell(searchModel: SearchModel) {
    textLabel?.text = searchModel.title
    detailTextLabel?.text = searchModel.author
  }
}
//
class BasicTableViewCell: UITableViewCell {}

