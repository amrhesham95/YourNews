//
//  News.swift
//  YourNews
//
//  Created by Amr Hesham on 23/04/2021.
//

import Foundation

public struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [News]?
}

// MARK: - Article
public struct News: Codable {
    let newsSource: SourceNews?
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    var publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case newsSource = "source"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
public struct SourceNews: Codable {
    let id: String?
    let name: String?
}

// MARK: - News + ReadOnlyConvertible
//
extension News: ReadOnlyConvertible {
  public typealias ReadOnlyType = News
  
  public func toReadOnly() -> News {
    return self
  }
  public func toTypeErasedReadOnly() -> Any {
    return self
  }
}
