//
//  BlogViewController.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit

class BlogViewController: BaseTabPageViewController, BlogCoordinated {
    var coordinator: BlogCoordinatorStandard?
    var articles: [Article]?
    let cellId: String = String(describing: ArticleTableViewCell.self)
    let imageRepository = ImageRepository()
    let kCellHeight = 150.0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controllerTitle = "Blog"
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.separatorColor = UIColor.white
        self.tableView.backgroundColor = UIColor.white
    }
}

extension BlogViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? ArticleTableViewCell
        cell?.configureWithArticle(article: articles?[indexPath.row], repository: imageRepository)
        
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let urlStr = articles?[indexPath.row].link
        
        self.coordinator?.showArticleDetail(articleUrlString: urlStr)
    }
}
