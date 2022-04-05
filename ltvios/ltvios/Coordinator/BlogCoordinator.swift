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
    
    var rootViewController: UIViewController?
    
    func start() -> UIViewController? {
        return rootViewController
    }
    
    func showArticleDetail(articleUrlString: String?) {
        let webVC = WebViewController.instantiateFromStoryboard()
        webVC.urlString = articleUrlString
        
        self.navigationViewController?.pushViewController(webVC, animated: true)
    }
}
