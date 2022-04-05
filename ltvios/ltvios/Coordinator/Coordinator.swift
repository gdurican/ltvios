//
//  Coordinator.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit
/*
    Coordinator protocol, having the navigation moved out of the view controllers.
    Every controller has a coordinator which is told to handle the navigation.
    This way, instead of having controllers with multiple methods of instantiating + configuring other view controllers and then telling their
    navigation controllers to show them, we simply call coordinator.takeMeToThatScreen() and everything happens under the hood.
 */
protocol Coordinator {
    var parentCoordinator: MainCoordinatorStandard? { get set }
    var rootViewController: UIViewController? { get set }

    func start() -> UIViewController?
    @discardableResult func resetToRoot() -> Self
}

protocol MainCoordinatorStandard: Coordinator {
    var blogCoordinator: BlogCoordinatorStandard { get }
    var mapCoordinator: MapCoordinatorStandard { get }
    
    func changeTab(tab: Tab)
}

protocol SplashCoordinatorStandard: Coordinator {
    //the actual navigation methods
    func showMainTabBarController(articles: [Article]?)
}

protocol BlogCoordinatorStandard: Coordinator {
    //the actual navigation methods
    func showArticleDetail(articleUrlString: String?)
}

protocol MapCoordinatorStandard: Coordinator {
    //the actual navigation methods
}

protocol SplashCoordinated {
    var coordinator: SplashCoordinatorStandard? { get }
}

protocol BlogCoordinated {
    var coordinator: BlogCoordinatorStandard? { get }
}

protocol MapCoordinated {
    var coordinator: MapCoordinatorStandard? { get }
}


extension Coordinator {
    var navigationViewController: UINavigationController? {
        get {
            return rootViewController?.navigationController
        }
    }
    
    func resetToRoot() -> Self {
        navigationViewController?.popToRootViewController(animated: true)
        
        return self
    }
}
