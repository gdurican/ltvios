//
//  API.swift
//  ltvios
//
//  Created by gabriel durican on 4/1/22.
//

import Foundation

enum ArticleAPI {
    case articleList
    case article(url: String)
}

extension ArticleAPI: EndPointType {
    var baseURL: URL {
        let url = URL(string: "https://hiring.ltvops.com")!
        return url
    }
    
    var path: String? {
        switch self {
        case .articleList:
            return "/articles/index.mobile-ios.json"
        case .article(_):
            return ""
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type" : "application/json"]
    }
    
    var task: HTTPTask {
        return .requestParametersAndHeaders(additionalHeaders: headers)
    }
    
    
}
