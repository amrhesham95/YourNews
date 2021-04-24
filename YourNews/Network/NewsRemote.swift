//
//  NewsRemote.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

// MARK: - NewsRemote
//
class NewsRemote: NewsRemoteProtocol {
  
  var network: Networkable?
  
  init(network: Networkable) {
    self.network = network
  }
  
  func getHeadlines(request: NewsSearchRequest, searchWord: String, completionHandler: @escaping RemoteNewsCompletionHandler) {
    
    let target: NewsAPI = .topheadlines(request: request, searchWord: searchWord)
    network?.fetchData(target: target, complitionHandler: completionHandler)
  }
}
