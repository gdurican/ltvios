//
//  EndPoint.swift
//  ltvios
//
//  Created by gabriel durican on 4/1/22.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var task: HTTPTask { get }
}

enum HTTPMethod: String {
    case get            = "GET"
    case post           = "POST"
    case put            = "PUT"
    case patch          = "PATCH"
    case delete         = "DELETE"
}

typealias HTTPHeaders = [String : String]

enum HTTPTask {
    case request
    case requestParameters(bodyParametrs: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters? = nil, urlParameters: Parameters? = nil, additionalHeaders: HTTPHeaders?)
}
