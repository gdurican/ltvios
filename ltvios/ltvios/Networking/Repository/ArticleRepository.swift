//
//  ArticleRepository.swift
//  ltvios
//
//  Created by gabriel durican on 4/1/22.
//

import Foundation

class ArticleRepository: ObjectRepositoryBase {
    typealias T = Article
    
    var router = Router<ArticleAPI>()
    var manager = NetworkManager()
    
    func get(id: String?, completion: @escaping (Article?, String?) -> ()) {
        //TBD
    }
    
    func getList(completion: @escaping ([Article]?, String?) -> ()) {
        router.request(.articleList) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.manager.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let articleData = try JSONDecoder().decode(ArticleData.self, from: responseData)
                        
                        completion(articleData.articles, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    
}
    
