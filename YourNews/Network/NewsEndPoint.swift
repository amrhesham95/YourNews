//
//  NewsEndPoint.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

import Moya

enum NewsAPI {
  case topheadlines(request: NewsSearchRequest, searchWord: String)
}

extension NewsAPI {
  var sampleData: Data {
    return Data()
  }
}



extension NewsAPI: TargetType {
  
  
  var baseURL: URL {
    return URL(string:"https://newsapi.org/v2/")!
  }
  
  var path: String {
    switch self {
    
    case .topheadlines:
      return "top-headlines"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  
  
  var parameters:[String:Any] {
    switch self {
    
    
    case .topheadlines(let request, let searchWord):
      return [Constants.API_country: request.country,
              Constants.API_category: request.categories,
              Constants.API_searchWord: searchWord,
              Constants.API_key: Constants.API_Key_Value,
              Constants.API_pageSize: request.pageSize,
              Constants.API_page: request.pageNumber]
    }
    
  }
  
  
  var task: Task {
    switch self {
    
    case .topheadlines(let request, let searchWord):
      return .requestParameters(parameters: [Constants.API_country: request.country,
                                             Constants.API_category: request.categories,
                                             Constants.API_searchWord: searchWord,
                                             Constants.API_key: Constants.API_Key_Value,
                                             Constants.API_pageSize: request.pageSize,
                                             Constants.API_page: request.pageNumber,
                                             Constants.API_sortBy: Constants.API_sortByDate],
                                encoding: URLEncoding.queryString)
    }
  }
  
  
  
  var headers: [String : String]? {
    return ["Content-type":"application/json"]
  }
}
