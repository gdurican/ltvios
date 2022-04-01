//
//  MainTabViewController.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

class MainTabViewController: UITabBarController, Storyboarded {
    
    func passArticlesToBlog(articles: [Article]?) {
        guard let blog = self.viewControllers?[0] as? BlogViewController, let articles = articles else {
            return
        }
        
        blog.articles = articles
    }
    
    
    
}
