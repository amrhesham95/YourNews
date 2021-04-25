import UIKit

/// An interface for search UI associated with a generic model and cell view model.
protocol SearchUICommand: NSObject {
  associatedtype Model
  associatedtype CellViewModel
  associatedtype EmptyStateViewControllerType: UIViewController = EmptyStateViewController
  
  /// The placeholder of the search bar.
  var searchBarPlaceholder: String { get }
  
  associatedtype ResultsControllerModel: ResultsControllerMutableType where ResultsControllerModel.ReadOnlyType == Model
  
  /// Creates a results controller for the search results. The result model's readonly type matches the search result model.
  var resultsController: ResultsController<ResultsControllerModel> { get }
  
  /// Init with action on select search result callback
  ///
  init(newsStore:  NewsStoreProtocol, onSelectSearchResult: ((Model) -> Void)?)

  /// The controller of the view to show if there is no text entered in the search bar.
  ///
  /// This will only be called once when `SearchViewController` is loaded and will be retained
  /// until `SearchViewController` is deallocated.
  ///
  /// The `view` of this controller will be added and constrained to the same size as the
  /// `SearchViewController`'s `tableView`.
  ///
  /// If `nil`, the search results tableView will be shown as the starter instead.
  ///
  func createStarterViewController() -> UIViewController?
  
  /// The controller of the view to show if the search results are empty.
  ///
  /// This will only be called if `SearchViewController` receives empty results. It will be
  /// retained once it has been created.
  ///
  /// The `view` of this controller will be added and constrained to the same size as the
  /// `SearchViewController`'s `tableView` but below the search bar.
  ///
  /// If not provided, an `EmptySearchResultsViewController` will be created instead.
  ///
  func createEmptyStateViewController() -> EmptyStateViewControllerType
  
  /// Called before showing the `EmptyStateViewControllerType` view.
  ///
  /// This allows `SearchUICommand` implementations to customize the
  /// `EmptyStateViewControllerType` instance after a search attempt was made and the results
  /// are empty. For example, a title label can be changed to "No results for {searchKeyword}".
  ///
  /// This is optional.
  ///
  /// - Parameter viewController: The controller created in `createEmptyStateViewController`.
  ///
  func configureEmptyStateViewControllerBeforeDisplay(viewController: EmptyStateViewControllerType,
                                                      searchKeyword: String)
  
  /// Optionally configures the action button that dismisses the search UI.
  /// - Parameters:
  ///   - button: the button in the navigation bar that dismisses the search UI. Shows "Filter" by default.
  ///   - onDismiss: called when it is ready to dismiss the search UI.
  func configureActionButton(_ button: UIButton, onDismiss: @escaping () -> Void)
  
  /// Creates a view model for the search result cell.
  ///
  /// - Parameter model: search result model.
  /// - Returns: a view model based on the search result model.
  func createCellViewModel(model: Model) -> CellViewModel
  
  /// Synchronizes the models matching a given keyword.
  func synchronizeModels(keyword: String,
                         pageNumber: Int,
                         pageSize: Int,
                         isSearchMode: Bool,
                         onCompletion: ((Bool) -> Void)?)
  
  /// Called when user selects a search result.
  ///
  /// - Parameters:
  ///   - model: search result model.
  ///   - viewController: view controller where the user selects the search result.
  ///   - reloadData: called when UI reload is necessary.
  ///   - updateActionButton: called when action button update is necessary.
  func didSelectSearchResult(model: Model, from viewController: UIViewController, reloadData: () -> Void, updateActionButton: () -> Void)
  
  /// The Accessibility Identifier for the search bar
  var searchBarAccessibilityIdentifier: String { get }
  
  /// The Accessibility Identifier for the cancel button
  var cancelButtonAccessibilityIdentifier: String { get }
}

// MARK: - Default implementation
extension SearchUICommand {
  
  func createStarterViewController() -> UIViewController? {
    // Return retults table view by default
    return nil
  }

  func configureActionButton(_ button: UIButton, onDismiss: @escaping () -> Void) {
    // If not implemented, keeps the default cancel UI/UX
  }
  
  /// The Accessibility Identifier for the search bar
  var searchBarAccessibilityIdentifier: String {
    // Accessibility is not implemented
    return ""
  }
  
  /// The Accessibility Identifier for the cancel button
  var cancelButtonAccessibilityIdentifier: String {
    // Accessibility is not implemented
    return ""
  }
}

// MARK: - SearchUICommand using EmptySearchResultsViewController

extension SearchUICommand {
  
  /// Creates an instance of `EmptySearchResultsViewController`
  ///
  func createEmptyStateViewController() -> EmptyStateViewController {
    EmptyStateViewController()
  }
  
  /// Default implementation which does not do anything.
  ///
  func configureEmptyStateViewControllerBeforeDisplay(viewController: EmptyStateViewController,
                                                      searchKeyword: String) {
    // noop
  }
}
