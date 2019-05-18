//
//  ArticleTableViewCell.swift
//  Carrito
//
//  Created by José Antonio Arellano Mendoza on 5/7/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import UIKit

protocol ArticleTableViewCellDelegate {
    //Metodos que implementaremos en el ViewController
    func didTapAdd(article: Article)
}

class ArticleTableViewCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    //Delegate sera el ViewController
    var delegate: ArticleTableViewCellDelegate?
    var articleItem: Article!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Constraints
        symbolLabel.textAlignment = .center
        symbolLabel.anchor(top: contentView.topAnchor, leading: contentView.layoutMarginsGuide.leadingAnchor, trailing: nil, bottom: nil, size: CGSize(width: contentView.frame.size.height, height: contentView.frame.size.height))
        
        nameLabel.textAlignment = .left
        nameLabel.anchor(top: contentView.topAnchor, leading: symbolLabel.trailingAnchor, trailing: nil, bottom: nil, size: CGSize(width: 100, height: contentView.frame.size.height))
        
        priceLabel.textAlignment = .right
        priceLabel.anchor(top: contentView.topAnchor, leading: nameLabel.trailingAnchor, trailing: nil, bottom: nil, size: CGSize(width: 150, height: contentView.frame.size.height))
        
        addButton.backgroundColor = .white
        addButton.layer.cornerRadius = 5
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor(red:0.89, green:0.42, blue:0.42, alpha:1.0).cgColor
        addButton.tintColor = UIColor(red:0.89, green:0.42, blue:0.42, alpha:1.0)
        addButton.anchor(top: contentView.layoutMarginsGuide.topAnchor, leading: nil, trailing: contentView.layoutMarginsGuide.trailingAnchor, bottom: contentView.layoutMarginsGuide.bottomAnchor)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Functions
    func update(with article: Article) {
        symbolLabel.text = article.symbol
        nameLabel.text = article.name
        priceLabel.text = String(format: "$%.2f", article.price)
        articleItem = article
    }
    
    //Actions
    @IBAction func addArticle(_ sender: UIButton) {
        delegate?.didTapAdd(article: articleItem)
    }
    
}
