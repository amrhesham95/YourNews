//
//  Country.swift
//  YourNews
//
//  Created by Amr Hesham on 26/04/2021.
//

import Foundation

// MARK: - Country
//
struct Country: Codable {
  let name: String
  let code: String
}

// MARK: - Country+Equatable
//
extension Country: Equatable {}

// MARK: - Country+CustomStringConvertible
//
extension Country: CustomStringConvertible {
  var description: String {
    self.name
  }
}
