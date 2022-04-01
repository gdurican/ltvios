//
//  Coordinator.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var parentCoordinator: MainCoordinatorStandard? { get set }
    var rootViewController: UIViewController { get set }

    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

protocol MainCoordinatorStandard: Coordinator {
    var blogCoordinator: BlogCoordinatorStandard { get }
    var mapCoordinator: MapCoordinatorStandard { get }
    
    func changeTab(tab: Tab)
}

protocol BlogCoordinatorStandard: Coordinator {
    //here add the actual navigation methods
}

protocol MapCoordinatorStandard: Coordinator {
    //here add the actual navigation methods
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
            (rootViewController as? UINavigationController)
        }
    }
    
    func resetToRoot() -> Self {
        navigationViewController?.popToRootViewController(animated: true)
        
        return self
    }
}
