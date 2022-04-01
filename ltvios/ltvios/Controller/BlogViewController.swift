//
//  BlogViewController.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

class BlogViewController: UIViewController, Storyboarded, BlogCoordinated {
    var coordinator: BlogCoordinatorStandard?
    var articles: [Article]?
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.text = "WE HAVE \(articles?.count ?? 1337) articles"
    }
    
}
