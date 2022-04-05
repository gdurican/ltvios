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
        //update UI elements to show the article data
        titleLabel.text = article?.title?.trimmingCharacters(in: .whitespacesAndNewlines)
        descriptionLabel.text = article?.description
        authorLabel.attributedText = authorAttrString(authorStr: article?.author)
        dateLabel.text = DateFormatter.dayMonthYearFormat.string(from: article?.date ?? Date())
    }
    
    func authorAttrString(authorStr: String?, font: UIFont? = UIFont.systemFont(ofSize: 12.0), boldFont: UIFont? = UIFont.boldSystemFont(ofSize: 12.0)) -> NSMutableAttributedString? {
        //creates an atrributed string like 'by AUTHOR', where AUTHOR will be bolded
        guard let authorStr = authorStr else {
            return nil
        }
        
        let byAttributed = NSMutableAttributedString(string: "by ", attributes: [NSAttributedString.Key.font : font!])
        let authorAttributed = NSMutableAttributedString(string: authorStr, attributes: [NSAttributedString.Key.font : boldFont!])
        
        byAttributed.append(authorAttributed)
        
        return byAttributed
    }
    
    func configureWithArticle(article: Article?, repository: ImageRepository?) {
        guard let article = article, let imageUrl = article.image else {
            return
        }
        
        //set the article object to start the UI update
        self.article = article
        
        //bind the image download to a local variable so on prepareForReuse method the download gets cancelled
        //this way, a quick scroll through the table view will not show any lag
        task = repository?.getData(imageUrl, completion: { [weak self] data, error in
            guard let self = self, let imageData = data else {
                return
            }
            
            DispatchQueue.main.async {
                self.artImageView.image = UIImage(data: imageData )
            }
            
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //when the system prepares the cell object to be reused, we set the image back to the placeholder and cancel the current image download
        task?.cancel()
        artImageView.image = UIImage(named: "placeholder")
    }
}
