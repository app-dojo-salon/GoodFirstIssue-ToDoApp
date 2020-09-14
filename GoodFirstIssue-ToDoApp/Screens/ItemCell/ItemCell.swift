//
//  ItemCell.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Ryota Miyazaki on 2020/09/14.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    static let reuseIdentifier = "ItemCell"

    @IBOutlet weak var checkedImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkedImage.image = nil
        itemNameLabel.text = nil
    }
    
    func configure(name: String, checked: Bool) {
        itemNameLabel.text = name
        checkedImage.isHidden = checked
    }
    
    static func loadNib() -> UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
}
