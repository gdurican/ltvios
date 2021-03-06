//
//  ImageRepository.swift
//  ltvios
//
//  Created by gabriel durican on 4/1/22.
//

import Foundation

class ImageRepository: ImageRepositoryBase {
    var router = Router<ImageAPI>()
    var manager = NetworkManager()
    let imageCache = NSCache<NSString, LocalImageData>()
    
    typealias R = ImageAPI
    
    func getData(_ urlString: String, completion: @escaping (Data?, String?) -> ()) -> Cancellable? {
        guard urlString.count > 0 else {
            return nil
        }
        
        //if there is already an image cached for that url, return that one and don't do the request again
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                completion(imageFromCache.data, nil)
            }
        }
        
        let task = router.request(.image(urlString: urlString)) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                //check the http code of the request and further send it in one of the 2 categories: success or failure
                let result = self.manager.handleNetworkResponse(response)
                
                switch result {   
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        
                        return
                    }
                    
                    //cache the image
                    let dataObject = LocalImageData(data: responseData)
                    self.imageCache.setObject(dataObject, forKey: urlString as NSString)
                    
                    completion(responseData, nil)
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
        
        return task
    }
}

