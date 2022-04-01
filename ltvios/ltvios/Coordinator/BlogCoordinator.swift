//
//  BlogCoordinator.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

class BlogCoordinator: BlogCoordinatorStandard {
    var parentCoordinator: MainCoordinatorStandard?
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let vc = BlogViewController.instantiateFromStoryboard()
        
        return vc
    }    
}
