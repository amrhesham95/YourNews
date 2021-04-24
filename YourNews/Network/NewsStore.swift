//
//  NewsStore.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

// MARK: - NewsStore
//
class NewsStore: NewsStoreProtocol {
  
  // MARK: - Properties
  
  var remote: NewsRemoteProtocol?
  
  // MARK: - Init
  
  init(remote: NewsRemoteProtocol) {
    self.remote = remote
  }
  
  // MARK: - Handlers
  
  func getHeadlines(request: NewsSearchRequest, searchWord: String, complitionHandler: @escaping StoreNewsCompletionHandler) {
    remote?.getHeadlines(request: request, searchWord: searchWord) { response, error in
      guard let response = response, error == nil else {
        complitionHandler(.failure(error ?? GeneralError()))
        return
      }
      
      complitionHandler(.success(response))
    }
  }
}



// MARK: - GeneralError
//
extension GeneralError: LocalizedError {
  
  public var errorDescription: String? {
    return "Something went wrong!"
  }
}

// MARK: - GeneralError
//
public struct GeneralError: Error {

  public init() { }
}
