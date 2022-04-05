//
//  BaseTabPageViewController.swift
//  ltvios
//
//  Created by gabriel durican on 4/3/22.
//

import Foundation
import UIKit

enum PageType {
    case Blog
    case Map
}

class BaseTabPageViewController: UIViewController, Storyboarded {
    var controllerTitle: String? = ""
    var type: PageType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        //some basic navigation+tab bars configurations, together with some handles for new iOS 15 issues
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
        
        self.tabBarController?.tabBar.standardAppearance = tappearance
        self.tabBarController?.tabBar.scrollEdgeAppearance = tappearance
    }
}
