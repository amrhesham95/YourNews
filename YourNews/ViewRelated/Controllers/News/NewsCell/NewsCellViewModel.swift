//
//  NewsCellViewModel.swift
//  YourNews
//
//  Created by Amr Hesham on 27/04/2021.
//

import Foundation

// MARK: - NewsCellViewModel
//
class NewsCellViewModel: ViewModel {
  
  // MARK: - Properties
  var model: StorageNews
  
  var numberOfRows: Int {
    listSubject.value.count
  }
    
  private var listSubject = BehaviorSubject<[StorageNews]>([])
  
  var listObservable: Observable<[StorageNews]> {
    return listSubject
  }
  
  init(model: StorageNews) {
    self.model = model
  }
  
  var url: String {
    model.url
  }
}

// MARK: - NewsCellViewModel+NewsCellRepresentable
//
extension NewsCellViewModel: NewsCellRepresentable {
  var title: String? {
    model.title
  }
  var description: String? {
    model.articleDescription
  }
  
  var date: String? {
    model.publishedAt
  }
  
  var source: String? {
    model.sourceNewsName
  }
  
  var imageURL: String? {
    model.urlToImage
  }
  
  var isFavorite: Bool? {
    return try! ServiceLocator.newsStore.isFavorite(article: model)
  }
}

// MARK: - News + ReadOnlyConvertible
//
extension NewsCellViewModel: ReadOnlyConvertible {
  public typealias ReadOnlyType = NewsCellViewModel
  
  public func toReadOnly() -> NewsCellViewModel {
    return self
  }
  public func toTypeErasedReadOnly() -> Any {
    return self
  }
}
