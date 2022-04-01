//
//  SplashScreenViewController.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    let repo = ArticleRepository()
    var articles: Article?
    
    //create a lazy transition, to be initialised when it is first required
    //this transition will replace the default push animation when setting the new view controllers array on the navigation controller
    lazy var pushTransition: CATransition = {
        let transition: CATransition = CATransition()
        transition.duration = 1.0
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade

        return transition
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newVC = MainCoordinator().start() as? MainTabViewController
        
        repo.getList { articles, error in
            
            
            DispatchQueue.main.async {
                guard let vc = newVC else {
                    return
                }
                
                vc.passArticlesToBlog(articles: articles)
                
                self.navigationController?.view.layer.add(self.pushTransition, forKey: nil)
                self.navigationController?.setViewControllers([vc], animated: false)
            }
            
        }
    }
}


