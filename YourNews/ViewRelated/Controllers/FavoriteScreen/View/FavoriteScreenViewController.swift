//
//  FavoriteScreenViewController.swift
//  YourNews
//
//  Created by Amr Hesham on 27/04/2021.
//

import UIKit

class FavoriteScreenViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Properties
  
  private let viewModel = FavoriteScreenViewModel()
  let disposeBag = DisposeBag()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    configureViewModel()
    viewModel.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    viewModel.loadAllFavorites()
  }
}

// MARK: - View Configurations
//
extension FavoriteScreenViewController {
  func registerCells(in tableView: UITableView) {
    tableView.registerNib(for: NewsCell.self)
  }
  
  func configureTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    registerCells(in: tableView)
  }
}

// MARK: - ViewModel Configurations
//
extension FavoriteScreenViewController {
  func configureViewModel() {
    viewModel.listObservable.subscribe { [weak self] _ in
      self?.tableView.reloadData()
    }.disposed(by: disposeBag)
  }
}

// MARK: - FavoriteScreenViewController + UITableViewDataSource
//
extension FavoriteScreenViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(NewsCell.self, for: indexPath)
    let model = viewModel.modelFor(indexPath.row)
    cell.configureCell(searchModel: model)
    cell.shouldReloadTableView = { [weak self] in
      self?.viewModel.loadAllFavorites()
    }
    return cell
  }
}

// MARK: - FavoriteScreenViewController + UITableViewDelegate
//
extension FavoriteScreenViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let model = viewModel.modelFor(indexPath.row)
    WebviewHelper.launch(model.url, with: self)
  }
}

