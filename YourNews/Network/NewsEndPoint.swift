//
//  NewsEndPoint.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

import Moya

enum NewsAPI {
  case topheadlines(country:String , category:String, searchWord: String, pageSize:Int , page:Int)
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
    
    
    case .topheadlines(let country, let category, let searchWord, let pageSize, let page):
      return [Constants.API_country: country,
              Constants.API_category: category,
              Constants.API_searchWord: searchWord,
              Constants.API_key: Constants.API_Key_Value,
              Constants.API_pageSize: pageSize,
              Constants.API_page: page]
    }
    
  }
  
  
  var task: Task {
    switch self {
    
    case .topheadlines(let country, let category, let searchWord, let pageSize, let page):
      return .requestParameters(parameters: [Constants.API_country: country,
                                             Constants.API_category: category,
                                             Constants.API_searchWord: searchWord,
                                             Constants.API_key: Constants.API_Key_Value,
                                             Constants.API_pageSize: pageSize,
                                             Constants.API_page: page],
                                encoding: URLEncoding.queryString)
    }
  }
  
  
  
  var headers: [String : String]? {
    return ["Content-type":"application/json"]
  }
  
  
}
