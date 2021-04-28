//
//  Category.swift
//  YourNews
//
//  Created by Amr Hesham on 4/28/21.
//

import Foundation

// MARK: - Category
//
struct Category: Codable {
  let title: String
  let value: String
}

// MARK: - Category+Hashable
//
extension Category: Hashable {}

// MARK: - Category+CustomStringConvertible
//
extension Category: CustomStringConvertible {
  var description: String {
    return title
  }
}
