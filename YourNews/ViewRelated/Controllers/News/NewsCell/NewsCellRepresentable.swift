//
//  NewsCellRepresentable.swift
//  YourNews
//
//  Created by Amr Hesham on 24/04/2021.
//

import Foundation

// MARK: - NewsCellRepresentable
//
protocol NewsCellRepresentable {
  
  var title: String? { get }
  var description: String? { get }
  var date: String? { get }
  var source: String? { get }
  var imageURL: String? { get }
  var isFavorite: Bool? { get }
}
