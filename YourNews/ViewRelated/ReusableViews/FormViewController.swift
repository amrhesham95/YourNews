//
//  FormViewController.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import UIKit
import Eureka

// MARK: - FormViewController
//
class FormViewController: Eureka.FormViewController {
  
  /// Stretchy Table Header View, Shall be called to be visible
  ///
  lazy var headerView = FormViewController.createAndConfigureHeaderView(in: self)
  
  /// Buttons Actions Footer View, Shall be called to be visible
  ///
  lazy var footerView = FormViewController.createAndConfigureFooterView(in: self)
 
  /// NavigationScrollBehavior
  /// - Note: Will not be inialized unless header view s created.
  ///
  private var navBehavior: NavigationScrollBehavior?
  
  /// Dispose bag
  ///
  let disposeBag = DisposeBag()

  // MARK: - Init
  
  init() {
    let style: UITableView.Style = {
      guard #available(iOS 13.0, *) else { return .plain }
      return .insetGrouped
    }()
    super.init(style: style)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    configureMainView()
    configureTableView()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.updateFooterHeight()
  }
  
  // MARK: - Overridden Properties
  
  override var progressType: ProgressViewType {
    return .fullscreen
  }
}

// MARK: - Configure View
//
private extension FormViewController {
    
  func configureMainView() {
    view.applyDefaultBackgroundStyle()
  }

  func configureTableView() {
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
  }
}

// MARK: - Handlers
//
extension FormViewController {

  /// Validate form and return errors list
  ///
  func validateWithErrorsIfExists(shouldScrollToFirstError: Bool = true) -> [Eureka.ValidationError] {
    let errors = form.validate()
    if shouldScrollToFirstError {
      scrollToFirstError()
    }
    
    return errors
  }
  
  /// Scroll to first error
  ///
  func scrollToFirstError(animated: Bool = true) {
    if let indexPath = form.allRows.first(where: { !$0.isValid })?.indexPath {
      tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
  }
}

// MARK: - Computed Properties
//
extension FormViewController {

  /// Returns reference to buttons currently added to footer view.
  ///
  var footerButtons: [UIButton] {
    return footerView.actions.map { $0.button }
  }
}

// MARK: - Handle Stretchy Table Header View
//
extension FormViewController {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let headerView = tableView.tableHeaderView as? StretchyTableHeaderView
    
    headerView?.scrollViewDidScroll(scrollView: scrollView)
    navBehavior?.scrollViewDidScroll(scrollView)
  }
}

// MARK: - Header/ Footer Factory
//
extension FormViewController {
  
  static func createAndConfigureFooterView(in viewController: FormViewController) -> ActionsFooterView {
    let footerView = ActionsFooterView()
    viewController.tableView.tableFooterView = footerView
    return footerView
  }
  
  static func createAndConfigureHeaderView(in viewController: FormViewController) -> StretchyTableHeaderView {
    let frame = CGRect(x: 0, y: 0, width: viewController.view.bounds.width, height: 250)
    let headerView = StretchyTableHeaderView(frame: frame)
    viewController.tableView.tableHeaderView = headerView
    
    viewController.navBehavior = NavigationScrollBehavior(viewController.navigationController)
    viewController.navBehavior?.updateHeight(250, shouldRespectSafeInsets: true)
    viewController.navBehavior?.tintColor = .primary
    viewController.navBehavior?.updateInitialOffset()
    
    return headerView
  }
}

// MARK: - ViewModel + State Binding Helpers
//
extension FormViewController {
  
  /// Bind loading state to ViewModel type
  ///
  /// - Parameter viewModel: ViewModel
  ///
  func bindLoadingState(to viewModel: ViewModel) {
    viewModel.state.subscribe { [weak self] state in
      self?.shouldShowLoading(state == .loading)
    }.disposed(by: disposeBag)
  }
  
  /// Bind error state to ViewModel type
  ///
  /// - Parameter viewModel: ViewModel
  ///
  func bindErrorState(to viewModel: ViewModel) {
    return viewModel.state.subscribe { [weak self] state in
      if case .failure(let error) = state {
//        self?.displayErrorNotice(error: error)
      }
    }.disposed(by: disposeBag)
  }
}

// MARK: - State Binding Helpers
//
private extension FormViewController {

  /// Pass true to show loading indicator, false to hide.
  ///
  func shouldShowLoading(_ showLoading: Bool) {
    shouldShowProgressView(showLoading, type: progressType)
  }
}
