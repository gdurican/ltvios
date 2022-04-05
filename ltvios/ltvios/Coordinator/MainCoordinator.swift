//
//  MainCoordinator.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

enum Tab {
    case Blog
    case Map
}


class MainCoordinator: MainCoordinatorStandard {
    var parentCoordinator: MainCoordinatorStandard?
   
    var blogCoordinator: BlogCoordinatorStandard = BlogCoordinator()
    var mapCoordinator: MapCoordinatorStandard = MapCoordinator()
    var rootViewController: UIViewController?
    
    func changeTab(tab: Tab) {
        switch tab {
        case .Blog:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .Map:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        }
        
    }
    
    func start() -> UIViewController? {
        rootViewController = MainTabViewController.instantiateFromStoryboard()
        let blogNav = (rootViewController as? MainTabViewController)?.viewControllers?[0] as? UINavigationController
        let blogVC = blogNav?.children.first
        (blogVC as? BlogViewController)?.coordinator = blogCoordinator
        blogCoordinator.rootViewController = blogVC ?? UIViewController()
        blogCoordinator.parentCoordinator = self
        
        let mapNav = (rootViewController as? MainTabViewController)?.viewControllers?[1] as? UINavigationController
        let mapVC = mapNav?.children.first
        (mapVC as? MapViewController)?.coordinator = mapCoordinator
        mapCoordinator.rootViewController = mapVC
        mapCoordinator.parentCoordinator = self

        return rootViewController
    }
    
    func resetToRoot() -> Self {
        blogCoordinator.resetToRoot()
        changeTab(tab: .Blog)
        
        return self
    }
}
