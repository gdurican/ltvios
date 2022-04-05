//
//  AlertController.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

class AlertController: NSObject {
    func present(on: UIViewController?,
                 title: String?,
                 message: String?,
                 cancelButtonTitle: String? = "OK",
                 onCancel: (() -> ())?) {
        guard let on = on else {
            return
        }
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            onCancel?()
        }
        
        alert.addAction(cancel)
        
        on.present(alert, animated: true, completion: nil)
    }
}
