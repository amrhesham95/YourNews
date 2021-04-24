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
  
  func getHeadlines(country: String, category: String, searchWord: String, pageSize: Int, page: Int, complitionHandler completionHandler: @escaping RemoteNewsCompletionHandler) {
    
    let target: NewsAPI = .topheadlines(country: country, category: category, searchWord: searchWord, pageSize: pageSize, page: page)
    network?.fetchData(target: target, complitionHandler: completionHandler)
  }
}
