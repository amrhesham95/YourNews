//
//  NewsStoreProtocol.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

// MARK: - Typealias
typealias StoreNewsCompletionHandler = (Result<NewsResponse, Error>) -> Void

// MARK: - NewsStoreProtocol
//
protocol NewsStoreProtocol {
  
  var remote: NewsRemoteProtocol? {get set}
  
  /// Fetch headlines
  ///
  func getHeadlines(request: NewsSearchRequest, searchWord: String, complitionHandler: @escaping StoreNewsCompletionHandler)
}
