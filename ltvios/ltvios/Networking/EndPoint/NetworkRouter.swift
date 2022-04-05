//
//  NetworkRouter.swift
//  ltvios
//
//  Created by gabriel durican on 4/1/22.
//

import Foundation

typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {
    //make the URLSessionTask objects conform to Cancellable so we can return a Cancellable object
}

protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    
    @discardableResult func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) -> Cancellable?
}

class Router<EndPoint: EndPointType>: NetworkRouter {   
    @discardableResult func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) -> Cancellable? {
        let session = URLSession.shared
        let task: URLSessionTask?
        
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
            
            task?.resume()
            
            return task
        } catch {
            completion(nil, nil, error)
            
            return nil
        }
    }

    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var url = route.baseURL
        if route.path != nil {
            url = route.baseURL.appendingPathComponent(route.path!)
        }
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.method.rawValue
        do {
            switch route.task {
            case .request:
                return request
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let headers):
                self.addAdditionalHeaders(headers, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else {
            return
        }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

