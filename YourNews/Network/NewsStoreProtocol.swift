//
//  NewsRepoProtocol.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

// MARK: - Typealias
typealias RemoteNewsCompletionHandler = (NewsResponse?, APIError?) -> Void

// MARK: - NewsRepoProtocol
//
protocol NewsRemoteProtocol {
  
  var network: Networkable? {get set}
  
  /// Fetch headlines 
  ///
  func getHeadlines(country: String, category: String, pageSize: Int, page: Int, complitionHandler:  @escaping RemoteNewsCompletionHandler)
}
