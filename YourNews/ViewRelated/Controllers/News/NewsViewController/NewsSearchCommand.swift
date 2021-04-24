//
//  NewsSearchCommand.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import UIKit

/// Implementation of `SearchUICommand` for departments search.
///
final class NewsSearchCommand: NSObject, SearchUICommand {
  
  // MARK: - Typealiases
  typealias Model = News
  typealias CellViewModel = News
  typealias ResultsControllerModel = News
  
  // MARK: - Callbacks
  
  private let onSelectSearchResult: ((Model) -> Void)?
  
  // MARK: - Properties
  
  let searchBarPlaceholder: String = Strings.searchBarPlaceholder
  
  let resultsController: ResultsController<ResultsControllerModel> = {
    return ResultsController<Model>()
  }()
  
  private(set) var newsStore: NewsStoreProtocol
  private(set) var newsFilter: NewsFilter = NewsFilter(country: "", categories: Set<String>())
  
  // MARK: Init
  
  init(newsStore:  NewsStoreProtocol = NewsStore(remote: NewsRemote(network: NetworkManager())), onSelectSearchResult: ((News) -> Void)?) {
    self.onSelectSearchResult = onSelectSearchResult
    self.newsStore = newsStore
  }
  
  // MARK: Handlers
  
  /// Create cell view model
  ///
  func createCellViewModel(model: Model) -> CellViewModel {
    return model
  }
  
  func configureEmptyStateViewControllerBeforeDisplay(viewController: EmptyStateViewController,
                                                      searchKeyword: String) {

      let format = "We're sorry, we couldn't find results"
      let message = NSAttributedString(string: format)

    DispatchQueue.main.async {
      viewController.configure(.simple(message: message, image: Asset.placeholderImageIcon.image))
    }
  }
  
  /// Synchronizes the departments matching a given Keyword
  ///
  func synchronizeModels(keyword: String, pageNumber: Int, pageSize: Int, isSearchMode: Bool, onCompletion: ((Bool) -> Void)?) {
    resetIfNeeded(pageNumber, isSearchMode: isSearchMode)
    newsStore.getHeadlines(country: "za", category: "business", searchWord: keyword, pageSize: pageSize, page: pageNumber) { [weak self] result in
      switch result {
      case .success(let response):
        self?.handleSuccessResponse(response)
        onCompletion?(response.totalResults ?? .zero == pageSize)
      case .failure:
        onCompletion?(false)
      }
    }
  }
  
  func didSelectSearchResult(model: Model, from viewController: UIViewController, reloadData: () -> Void, updateActionButton: () -> Void) {
    onSelectSearchResult?(model)
  }
  
  func handleSuccessResponse(_ response: NewsResponse) {
    let articles = response.articles ?? []
    resultsController.insert(articles)
  }
}

// MARK: - Private Helpers
//
private extension NewsSearchCommand {
  
  /// Reset results controller
  ///
  private func resetIfNeeded(_ pageNumber: Int, isSearchMode: Bool) {
    if pageNumber == .zero || isSearchMode {
      resultsController.reset()
    }
  }
}

// MARK: - Constants
private extension NewsSearchCommand {
  
  enum Strings {
    static var searchBarPlaceholder: String { "Search articles" }
  }
}
