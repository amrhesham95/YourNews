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
  
  var onFilterChange: (() -> Void)?
  
  // MARK: - Properties
  
  let searchBarPlaceholder: String = Strings.searchBarPlaceholder
  
  let resultsController: ResultsController<ResultsControllerModel> = {
    return ResultsController<Model>()
  }()
  
  private(set) var newsStore: NewsStoreProtocol
  private(set) var newsFilter: NewsFilter? = ServiceLocator.defaultFilter {
    didSet {
      onFilterChange?()
    }
  }
  
  /// Throttler instance to control sending search requests
  ///
  private lazy var throttler: Throttler = Throttler(seconds: 1)

  
  // MARK: Init
  
  init(newsStore:  NewsStoreProtocol = ServiceLocator.newsStore, onSelectSearchResult: ((News) -> Void)?) {
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
    throttler.throttle { [weak self] in
      DispatchQueue.main.async {
        self?.resetIfNeeded(pageNumber, isSearchMode: isSearchMode)
        guard let request = self?.makeRequest(pageNumber: pageNumber, pageSize: pageSize) else { return }
        self?.newsStore.getHeadlines(request: request, searchWord: keyword) { [weak self] result in
          switch result {
          case .success(let response):
            
            self?.handleSuccessResponse(response)
            onCompletion?(response.totalResults ?? .zero == pageSize)
          case .failure:
            onCompletion?(false)
          }
        }
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

// MARK: - Public Handlers
//
extension NewsSearchCommand {
  
  func updateFilter(with filter: NewsFilter) {
    self.newsFilter = filter
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
  
  /// For resync request with filter
  /// - Parameters:
  ///   - pageNumber: Current page number
  ///   - pageSize: Current page size
  /// - Returns: Valid request as `NewsSearchRequest`
  private func makeRequest(pageNumber: Int, pageSize: Int) -> NewsSearchRequest? {
    guard let newsFilter = newsFilter else { return nil }
    return NewsSearchRequest(newsFilter: newsFilter, pageNumber: pageNumber, pageSize: pageSize)
  }
}

// MARK: - Constants
private extension NewsSearchCommand {
  
  enum Strings {
    static var searchBarPlaceholder: String { "Search articles".localized }
  }
}
