//
//  ShoppingListTableViewCell.swift
//  DebarsheeShoppingListDemo
//
//  Created by Debarshee on 4/3/21.
//

import UIKit
protocol CellReusable {
    static var cellIdentifier: String { get }
}

extension CellReusable {
    static var cellIdentifier: String {
        String(describing: self)
    }
}

class ShoppingListTableViewCell: UITableViewCell, CellReusable {
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var favouriteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.layer.cornerRadius = self.productImageView.frame.width / 10
        productImageView.clipsToBounds = true
        productImageView.layer.borderWidth = 1
        productImageView.layer.borderColor = UIColor.gray.cgColor
    }
    
    func configure(name: String, price: Double, image: String) {
        self.nameLabel.text = name
        self.priceLabel.text = "$" + String(format: "%.2f", price)
        let productImage = UIImage(named: image)
        self.productImageView.image = productImage
    }
    
}
