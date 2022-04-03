//
//  MainTabViewController.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

class MainTabViewController: UITabBarController, Storyboarded {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    func passArticlesToBlog(articles: [Article]?) {
        guard let blog = self.viewControllers?[0] as? BlogViewController, let articles = articles else {
            return
        }
        
        blog.articles = articles
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        
        let tappearance = UITabBarAppearance()
        tappearance.configureWithOpaqueBackground()
        tappearance.backgroundColor = UIColor.black
        
        self.tabBar.standardAppearance = tappearance
        self.tabBar.scrollEdgeAppearance = tappearance
    }
    
    
}
