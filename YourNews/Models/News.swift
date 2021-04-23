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
    let source: SourceNews?
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    var publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
public struct SourceNews: Codable {
    let id: String?
    let name: String?
}
