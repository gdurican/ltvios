//
//  Repository.swift
//  ltvios
//
//  Created by gabriel durican on 4/1/22.
//

import Foundation

//repository protocol to have everything request/response related 'under the hood' and from the other classes we just call repository.getWhatWeNeed
protocol Repository {
    associatedtype R: EndPointType
    
    var router: Router<R> { get set }
    var manager: NetworkManager { get set }
}

protocol ObjectRepositoryBase: Repository {
    associatedtype T
    
    func get(id: String?, completion: @escaping (T?, String?) -> ())
    func getList(completion: @escaping ([T]?, String?) -> ())
}

protocol ImageRepositoryBase: Repository {
    func getData(_ urlString: String, completion: @escaping (Data?, String?) -> ()) -> Cancellable?
}
