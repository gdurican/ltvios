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

//https://raw-data.getsandbox.com/mobile.json
extension ArticleAPI: EndPointType {
    var baseURL: URL {
        let url = URL(string: "https://raw-data.getsandbox.com")!
        return url
    }
    
    var path: String? {
        switch self {
        case .articleList:
            return "/mobile.json"
        case .article(let url):
            return ""
            #warning("GABI check here, probably needs to return directly in baseURL")
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
        #warning("GABI for images you probably add here the parameters")
    }
    
    
}
