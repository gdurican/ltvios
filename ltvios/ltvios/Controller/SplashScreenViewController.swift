//
//  SplashScreenViewController.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

class SplashScreenViewController: UIViewController, Storyboarded, SplashCoordinated {
    var coordinator: SplashCoordinatorStandard?
    let repo = ArticleRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repo.getList { articles, error in
            //switch to the main thread, because every UI action should be done there
            DispatchQueue.main.async {
                self.coordinator?.showMainTabBarController(articles: articles)
            }
            
        }
    }
}


