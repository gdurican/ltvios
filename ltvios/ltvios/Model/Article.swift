//
//  Article.swift
//  ltvios
//
//  Created by gabriel durican on 4/1/22.
//

import Foundation

struct ArticleData: Decodable {
    var articles: [Article]?
    var revision: String?
    
    enum ADCodingKeys: String, CodingKey {
        case articles
        case revision       = "last_rev"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ADCodingKeys.self)
        articles = try container.decodeIfPresent([Article].self, forKey: ADCodingKeys.articles)
        revision = try container.decodeIfPresent(String.self, forKey: ADCodingKeys.revision)
    }
    
    
}

struct Article: Decodable {
    let title: String?
    let description: String?
    let author: String?
    let image: String?
    var dateString: String?
    var date: Date?
    let link: String?
    let uuid: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case author
        case image
        case dateString           = "article_date"
        case link
        case uuid
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: CodingKeys.title)
        description = try container.decodeIfPresent(String.self, forKey: CodingKeys.description)
        author = try container.decodeIfPresent(String.self, forKey: CodingKeys.author)
        image = try container.decodeIfPresent(String.self, forKey: CodingKeys.image)
        dateString = try container.decodeIfPresent(String.self, forKey: CodingKeys.dateString)
        
        /*
         This is a workaround because for some unknown reason having the decoder.dateDecodingStrategy = .formatted(DateFormatter.ltvFormat)
         did not solve the problem. Even though when testing the format with date from string, it returned the correct result.
         */
        date = DateFormatter.ltvFormat.date(from: dateString ?? "")
        link = try container.decodeIfPresent(String.self, forKey: CodingKeys.link)
        uuid = try container.decodeIfPresent(String.self, forKey: CodingKeys.title)
    }
}
