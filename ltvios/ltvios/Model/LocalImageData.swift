//
//  LocalImageData.swift
//  ltvios
//
//  Created by gabriel durican on 4/2/22.
//

import Foundation

//creating this class to have an object for saving in the image cache
class LocalImageData {
    var data: Data?
    
    init(data: Data?) {
        self.data = data
    }
}
