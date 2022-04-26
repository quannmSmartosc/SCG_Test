//
//  Article.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import Foundation

struct Article: Codable {
    let source: Source?
    let author, title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

struct Source: Codable {
    let id, name: String?
}

struct NewsResponse: Codable {
    let status: String?
    let articles: [Article]?
    var totalResults: Int?
    let code: String?
    let message: String?
}
