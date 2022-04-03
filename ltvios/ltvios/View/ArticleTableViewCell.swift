//
//  ArticleTableViewCell.swift
//  ltvios
//
//  Created by gabriel durican on 4/2/22.
//

import Foundation
import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var artImageView: UIImageView!
    var task: Cancellable?
    
    var repo: ImageRepository?
    var article: Article? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        titleLabel.text = article?.title
        descriptionLabel.text = article?.description
        authorLabel.text = article?.author != nil ? "by \((article?.author)!)" : ""
        dateLabel.text = DateFormatter.dayMonthYearFormat.string(from: article?.date ?? Date())
    }
    
    func configureWithArticle(article: Article?, repository: ImageRepository?) {
        guard let article = article else {
            return
        }
        
        self.article = article
        let ht = "https://avatars.githubusercontent.com/u/46995138?v=4"
        task = repository?.getData(ht ?? "", completion: { [weak self] data, error in
//        task = repo?.getData(article.image ?? "", completion: { [weak self] data, error in
            print("WTF START")
            guard let self = self, let imageData = data else {
                return
            }
            

            print ("WTF")
            DispatchQueue.main.async {
//                if error != nil {
                    self.artImageView.image = UIImage(data: imageData )
//                }
            }
            
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
//        artImageView.image = UIImage(named: "placeholder")
    }
}
