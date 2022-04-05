//
//  SplashCoordinator.swift
//  ltvios
//
//  Created by gabriel durican on 4/5/22.
//

import Foundation
import UIKit

class SplashCoordinator: SplashCoordinatorStandard {    
    var parentCoordinator: MainCoordinatorStandard?
    var childrenCoordinators: [Coordinator]?
    
    var mainCoordinator = MainCoordinator()
   
    var rootViewController: UIViewController?
    
    //create a lazy transition, to be initialised when it is first required
    //this transition will replace the default push animation when setting the new view controllers array on the navigation controller
    lazy var pushTransition: CATransition = {
        let transition: CATransition = CATransition()
        transition.duration = 1.0
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade

        return transition
    }()
    
    func start() -> UIViewController? {
        rootViewController = SplashScreenViewController.instantiateFromStoryboard()
        (rootViewController as? SplashScreenViewController)?.coordinator = self
        let nav = UINavigationController(rootViewController: rootViewController!)
        nav.isNavigationBarHidden = true
        
        return nav
    }
    
    func showMainTabBarController(articles: [Article]?) {
        guard let tab = mainCoordinator.start() as? MainTabViewController else {
            return
        }
        
        tab.passArticlesToBlog(articles: articles)
        
        self.navigationViewController?.view.layer.add(self.pushTransition, forKey: nil)
        self.navigationViewController?.setViewControllers([tab], animated: false)
    }
    
    
}
