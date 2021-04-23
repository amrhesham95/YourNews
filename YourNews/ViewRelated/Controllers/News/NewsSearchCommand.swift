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
  
  let searchBarPlaceholder: String = "Search all departments"
  
  let resultsController: ResultsController<ResultsControllerModel> = {
    return ResultsController<Model>()
  }()
  
  // MARK: Init
  
  init(onSelectSearchResult: ((News) -> Void)?) {
    self.onSelectSearchResult = onSelectSearchResult
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
      viewController.configure(.simple(message: message, image: UIImage(named: "empty")!))
    }
  }
  
  /// Synchronizes the departments matching a given Keyword
  ///
  func synchronizeModels(keyword: String, pageNumber: Int, pageSize: Int, onCompletion: ((Bool) -> Void)?) {
    resetIfNeeded(pageNumber)
//    let data = DummyData()
//    guard let list: [News] = data.getData(with: keyword) else {
//       self.resultsController.insert([])
//      onCompletion?(false)
//      return
//    }
//    self.resultsController.insert(list)
//    onCompletion?(true)


  }
  
  func didSelectSearchResult(model: Model, from viewController: UIViewController, reloadData: () -> Void, updateActionButton: () -> Void) {
    onSelectSearchResult?(model)
  }
}

// MARK: - Private Helpers
//
private extension NewsSearchCommand {
  
  /// Reset results controller
  ///
  private func resetIfNeeded(_ pageNumber: Int) {
    if pageNumber == .zero {
      resultsController.reset()
    }
  }
}
