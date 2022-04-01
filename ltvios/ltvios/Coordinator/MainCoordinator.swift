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
    lazy var rootViewController: UIViewController = UITabBarController()
    
    func changeTab(tab: Tab) {
        switch tab {
        case .Blog:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .Map:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        }
        
    }
    
    func start() -> UIViewController {
        rootViewController = MainTabViewController.instantiateFromStoryboard()
        let blogVC = (rootViewController as? MainTabViewController)?.viewControllers?[0]
        (blogVC as? BlogViewController)?.coordinator = blogCoordinator
        blogCoordinator.parentCoordinator = self
        
        let mapVC = (rootViewController as? MainTabViewController)?.viewControllers?[1]
        (mapVC as? MapViewController)?.coordinator = mapCoordinator
        mapCoordinator.parentCoordinator = self

        return rootViewController
    }
    
    func resetToRoot() -> Self {
        blogCoordinator.resetToRoot()
        changeTab(tab: .Blog)
        
        return self
    }
}
