//
//  NewsCell.swift
//  NewsApp
//
//  Created by Amr Hesham on 24/04/2021.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import UIKit
import Kingfisher

//MARK: - delegate function

// delegate for add and remove from database
protocol NewsRealmDelegate {
  func toggleFavorite(cell: NewsCell)
}

// delegate for detect which source label is clicked
protocol SourceLabelClickableDelegate {
  func didClickedOnSourceLabel(at cell: NewsCell)
}

class NewsCell: UITableViewCell {
  
  //MARK: - Outlets
  @IBOutlet weak var newsImageView: UIImageView!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var sourceLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var starFavoriteBtn: UIImageView!
  
  //MARK: - Properties
  var favoriteDelegate: NewsRealmDelegate?
  var sourceLabelDelegate: SourceLabelClickableDelegate?
  var indexPath: IndexPath?
  
  var viewModel: NewsCellViewModel? {
    didSet {
      updateCell()
    }
  }

  var shouldReloadTableView: (() -> Void)?
  
  static let cellID = "\(NewsCell.self)"
  
  // MARK: - Lifecycle
  
  override func awakeFromNib() {
    setupSourceLabelClick()
    setupStarbuttonClick()
  }
  
  
  // MARK: - Handlers
  
  func setupStarbuttonClick() {
    let starButtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteBtnDidTapped(tapGestureRecognizer:)))
    starFavoriteBtn.isUserInteractionEnabled = true
    starFavoriteBtn.addGestureRecognizer(starButtnTapGestureRecognizer)
  }
  
  
  func setupSourceLabelClick() {
    let sourceLabelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sourceLabelDidTapped(tapGestureRecognizer:)))
    sourceLabel.isUserInteractionEnabled = true
    sourceLabel.addGestureRecognizer(sourceLabelTapGestureRecognizer)
  }
  
  
  
  @objc func sourceLabelDidTapped(tapGestureRecognizer: UITapGestureRecognizer){
    sourceLabelDelegate?.didClickedOnSourceLabel(at:self)
  }
  
  @objc func favoriteBtnDidTapped(tapGestureRecognizer: UITapGestureRecognizer){
    toggleFavorite()
  }
  
  func toggleFavorite() {
    
    guard let model = viewModel?.model else {
      return
    }
    let news = News(storageNews: model)
    viewModel?.isFavorite ?? false ? deleteFavorite(news) : addFavorite(news)
  }
  
  func addFavorite(_ model: News) {
    ServiceLocator.newsStore.addFavorite(article: model.storageNews, onCompletion: didReceiveIsFavoriteResult)
  }
  
  func deleteFavorite(_ model: News) {
    ServiceLocator.newsStore.deleteArticle(article: model.storageNews, onCompletion: didReceiveIsFavoriteResult)
  }
  
  func didReceiveIsFavoriteResult(_ result: Result<Bool, GeneralError>) {
    if case .success = result {
      shouldReloadTableView?()
    }
  }
}

// MARK: - View Configurations
//
extension NewsCell {
  func updateCell() {
    titleLabel?.text = viewModel?.title
    descriptionLabel?.text = viewModel?.description
    newsImageView?.setImage(urlString: viewModel?.imageURL, placeholder: Asset.placeholderImageIcon.image)
    dateLabel.text = viewModel?.date
    sourceLabel.text = viewModel?.source
    starFavoriteBtn.image = viewModel?.isFavorite ?? false ? Asset.favoriteStar.image : Asset.unfavoriteStar.image
  }
}

//MARK: - NewsCell+SearchResultCell

extension NewsCell: SearchResultCell {
  
  typealias SearchModel = NewsCellViewModel
  
  static func register(for tableView: UITableView) {
    tableView.registerNib(for: self)
  }
  
  func configureCell(searchModel: SearchModel) {
    viewModel = searchModel
  }
}

