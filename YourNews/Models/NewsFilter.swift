//
//  NewsFilter.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

// MARK: - NewsFilter
//
struct NewsFilter: Codable {
  var country: Country
  var categories: Set<String>
}
