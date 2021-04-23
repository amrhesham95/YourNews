//
//  NetworkManager.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation
import Moya

// MARK: - Networkable
//
protocol Networkable {
  func fetchData(target: NewsAPI , complitionHandler: @escaping (NewsResponse?, APIError?) -> Void)
  
}

// MARK: - NewtorkManger
//
class NetworkManager: Networkable {
  
  fileprivate let provider = MoyaProvider<NewsAPI>(plugins: [NetworkManager.loggingPlugin()])
  func fetchData(target: NewsAPI , complitionHandler: @escaping (NewsResponse?, APIError?) -> Void) {
    
    provider.request(target) { (result) in
      switch  result {
      case .success(let response) :
        do {
          let resultApi = try JSONDecoder().decode(NewsResponse.self, from: response.data)
          complitionHandler(resultApi,nil)
          
        }catch(let ex) {
          print(#function, "exception with: \(ex)")
          complitionHandler(nil,.notFound)
        }
        
      case .failure(let error) :
        print(#function, "error with: \(error)")
        complitionHandler(nil,.noInternet)
      }
    }
  }
}

// MARK: Helpers
//
private extension NetworkManager {
  
  /// Logging plugin
  ///
  static func loggingPlugin() -> NetworkLoggerPlugin {
    NetworkLoggerPlugin(
      configuration: .init(logOptions: .verbose)
    )
  }
}


