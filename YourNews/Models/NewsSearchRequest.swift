//
//  NewsSearchRequest.swift
//  YourNews
//
//  Created by Amr Hesham on 24/04/2021.
//

import Foundation

// MARK: - NewsSearchRequest
struct NewsSearchRequest {
  
  let country: String
  let categories: [String]
  let pageNumber: Int
  let pageSize: Int
}
