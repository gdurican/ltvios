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
    var title: String?
    var description: String?
    var author: String?
    var image: String?
    var dateString: String?
    var date: Date?
    var link: String?
    var uuid: String?
    
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
        let decodedImage: String? = try container.decodeIfPresent(String.self, forKey: CodingKeys.image)
        image = imageRebuiltUrlString(decodedImage)
        dateString = try container.decodeIfPresent(String.self, forKey: CodingKeys.dateString)
        
        /*
         This is a workaround because for some unknown reason having the decoder.dateDecodingStrategy = .formatted(DateFormatter.ltvFormat)
         did not solve the problem. Even though when testing the format with date from string, it returned the correct result.
         */
        date = DateFormatter.ltvFormat.date(from: dateString ?? "")
        link = try container.decodeIfPresent(String.self, forKey: CodingKeys.link)
        uuid = try container.decodeIfPresent(String.self, forKey: CodingKeys.title)
    }
    
    func imageRebuiltUrlString(_ urlStr: String?) -> String? {
        /*
         The original image url needs to be transformed so it includes the new parameters as well - fit-in, 60x0, filters:autojpg()
         What is done below is the string from the JSON gets transformed into a URL object so we can grab the path, the host and the last path component,
         which is the image name.
         Afterwards, we add the scheme + the host together with the new parameters and the image name in an array and then join the components by '/'
         */
        guard let urlStr = urlStr,
              let url = URL(string: urlStr),
              let scheme = url.scheme,
              let host = url.host,
              url.pathComponents.count > 1
        else {
            return ""
        }
        
        let imageName = url.pathComponents.last ?? ""
        let fitIn = "fit-in"
        let imageSize = "60x0"
        let filters = "filters:autojpg()"
        let newHost = scheme + "://" + host
        let newUrlStr = [newHost, fitIn, imageSize, filters, imageName].joined(separator: "/")
        
        return newUrlStr
    }
}
