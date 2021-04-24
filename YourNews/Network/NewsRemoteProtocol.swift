//
//  NewsRemoteProtocol.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

// MARK: - Typealias
typealias RemoteNewsCompletionHandler = (NewsResponse?, Error?) -> Void

// MARK: - NewsRepoProtocol
//
protocol NewsRemoteProtocol {
  
  var network: Networkable? {get set}
  
  /// Fetch headlines 
  ///
  func getHeadlines(request: NewsSearchRequest, searchWord: String, completionHandler: @escaping RemoteNewsCompletionHandler)
}
