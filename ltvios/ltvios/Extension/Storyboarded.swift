//
//  Storyboarded.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiateFromStoryboard() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiateFromStoryboard() -> Self {
        #warning("GABI check the comments here")
        //this returns something like app.ViewController
        let name = NSStringFromClass(self)
        
        //from app.ViewController --> ViewController
        let className = name.components(separatedBy: ".")[1]
        
        //instantiate the storyboard
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        return sb.instantiateViewController(identifier: className) as! Self
    }
}
