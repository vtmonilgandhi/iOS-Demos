//
//  Article.swift
//  GoodNews
//
//  Created by Monil Gandhi on 15/01/21.
//

import Foundation

struct Article: Decodable {
    let title: String
    let description: String?
}

extension ArticlesList {
    static var all: Resource<ArticlesList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e6d14eb3c00e4b3498682421168be320")!
        return Resource(url: url)
    }()
}

struct ArticlesList: Decodable {
    let articles: [Article]
}
