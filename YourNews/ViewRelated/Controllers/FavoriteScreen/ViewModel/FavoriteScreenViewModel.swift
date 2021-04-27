//
//  FavoriteScreenViewModel.swift
//  YourNews
//
//  Created by Amr Hesham on 27/04/2021.
//

import Foundation

// MARK: - FavoriteScreenViewModel
//
class FavoriteScreenViewModel: ViewModel {
  
  // MARK: - Properties
  
  var numberOfRows: Int {
    listSubject.value.count
  }
    
  private var listSubject = BehaviorSubject<[StorageNews]>([])
  
  var listObservable: Observable<[StorageNews]> {
    return listSubject
  }
  
  var unfavoriteHandler: (() -> Void)?

  
  // MARK: - Handlers
  
  func viewDidLoad() {
    loadAllFavorites()
  }
  
  func modelFor(_ row: Int) -> News {
    let storageNews = listSubject.value[row]
    return News(storageNews: storageNews)
  }
  
  func configureUnfavoriteHandler(handler: @escaping (() -> Void)) {
    unfavoriteHandler = handler
  }
}

// MARK: - Private Handlers
//
extension FavoriteScreenViewModel {
  
  func loadAllFavorites() {
    state.send(.loading)
    ServiceLocator.newsStore.fetchNews { [weak self] list, error in
      if let list = list {
        self?.listSubject.send(list)
        self?.state.send(.success)
      } else {
        guard let error = error else { return }
        self?.listSubject.send([])
        self?.state.send(.failure(error))
      }
    }
  }
  
  func removeFromFavorite(article: StorageNews) {
    ServiceLocator.newsStore.deleteArticle(article: article) { [weak self] _ in
      self?.loadAllFavorites()
      self?.unfavoriteHandler?()
    }
  }
}
