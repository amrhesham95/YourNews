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
  
  init(storageNews: StorageNews) {
    newsSource = SourceNews(id: storageNews.sourceNewsID, name: storageNews.sourceNewsName)
    author = storageNews.author
    title = storageNews.title
    articleDescription = storageNews.articleDescription
    url = storageNews.url
    urlToImage = storageNews.urlToImage
    publishedAt = storageNews.publishedAt
    content = storageNews.content
  }

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

// MARK: - News+Realm
extension News {
  var storageNews: StorageNews {
    let storageNews = StorageNews()
    storageNews.author = author ?? ""
    storageNews.articleDescription = articleDescription ?? ""
    storageNews.content = content ?? ""
    storageNews.publishedAt = publishedAt ?? ""
    storageNews.title = title ?? ""
    storageNews.url = url ?? ""
    storageNews.urlToImage = urlToImage ?? ""
    storageNews.sourceNewsID = newsSource?.id ?? ""
    storageNews.sourceNewsName = newsSource?.name ?? ""
    
    return storageNews
  }
}
