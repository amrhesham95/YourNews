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
    
    favoriteDelegate?.toggleFavorite(cell: self)
  }
}

//MARK: - NewsCell+SearchResultCell

extension NewsCell: SearchResultCell {
  
  typealias SearchModel = News
  
  static func register(for tableView: UITableView) {
    tableView.registerNib(for: self)
  }
  
  func configureCell(searchModel: SearchModel) {
    titleLabel?.text = searchModel.title
    descriptionLabel?.text = searchModel.author
    newsImageView?.setImage(urlString: searchModel.imageURL, placeholder: Asset.placeholderImageIcon.image)
    dateLabel.text = searchModel.date
    sourceLabel.text = searchModel.source
    starFavoriteBtn.image = searchModel.isFavorite ?? false ? Asset.favoriteStar.image : Asset.unfavoriteStar.image
  }
}

