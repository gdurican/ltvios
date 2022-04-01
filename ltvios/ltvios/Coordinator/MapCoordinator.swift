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
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let vc = MapViewController.instantiateFromStoryboard()
        vc.coordinator = self
        
        return vc
    }
    
    //add the actual navigator methods e.g go to blog item
}
