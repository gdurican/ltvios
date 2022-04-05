//
//  MapCoordinator.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

class MapCoordinator: MapCoordinatorStandard {
    var parentCoordinator: MainCoordinatorStandard?
    var childrenCoordinators: [Coordinator]?
    
    var rootViewController: UIViewController?
    
    func start() -> UIViewController? {
        return rootViewController
    }
}
