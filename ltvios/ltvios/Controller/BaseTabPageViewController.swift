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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.title = controllerTitle
    }
}
