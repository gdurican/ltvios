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
    
    typealias R = ImageAPI
    
#warning("GABI here change to retunr a URLDATATASK to use to cancel later")
    func getData(_ urlString: String, completion: @escaping (Data?, String?) -> ()) -> Cancellable? {
        //TBD
        
        return URLSessionTask()
    }
    
    #warning("GABI here ")
}

