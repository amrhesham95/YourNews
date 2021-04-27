//
//  NewsStoreProtocol.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

// MARK: - Typealias
typealias StoreNewsCompletionHandler = (Result<NewsResponse, Error>) -> Void
typealias  AddFavoriteNewsCompletion = ((Result<Bool, GeneralError>) -> Void)

// MARK: - NewsStoreProtocol
//
protocol NewsStoreProtocol {
  
  var remote: NewsRemoteProtocol? {get set}
  
  /// Fetch headlines
  ///
  func getHeadlines(request: NewsSearchRequest, searchWord: String, complitionHandler: @escaping StoreNewsCompletionHandler)
  
  /// Get news from local storage
  ///
  func fetchNews(completion: @escaping ([StorageNews]?, Error?) -> Void)
  
  /// Add article to favorite
  ///
  func addFavorite(article: StorageNews, onCompletion: @escaping  AddFavoriteNewsCompletion)
  
  /// Delete article
  ///
  func deleteArticle(article: StorageNews, onCompletion: @escaping  AddFavoriteNewsCompletion)
  
  func isFavorite(article: StorageNews) throws -> Bool
}
