//
//  NewsSearchRequest.swift
//  YourNews
//
//  Created by Amr Hesham on 24/04/2021.
//

import Foundation

// MARK: - NewsSearchRequest
struct NewsSearchRequest {
  let newsFilter: NewsFilter
  let pageNumber: Int
  let pageSize: Int
}