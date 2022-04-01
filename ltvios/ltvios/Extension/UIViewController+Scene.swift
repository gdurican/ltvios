//
//  UIViewController+Scene.swift
//  ltvios
//
//  Created by gabriel durican on 4/1/22.
//

import Foundation
import UIKit

extension UIViewController {
    /* In iOS 13 + the application can have multiple scenes, with multiple windows.
     Because of this, the pre iOS 13 value can't be used: UIApplication.shared.keyWindow?
     Instead, on this single scene app we need to get the first scene and select it's delegate's window.
     */
    
    var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = scene.delegate as? SceneDelegate,
              let window = delegate.window else {
                  return nil
              }
        
        return window
    }
}
