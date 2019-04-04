//
//  RestaurantCollectionViewCell.swift
//  vmc49_p5
//
//  Created by Victor Chen on 4/3/19.
//  Copyright © 2019 Victor Chen. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    var restaurantTextView: UITextView!
    
    let fontSize: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        restaurantTextView = UITextView(frame: .zero)
        restaurantTextView.translatesAutoresizingMaskIntoConstraints = false
        restaurantTextView.font = UIFont.systemFont(ofSize: fontSize)
        restaurantTextView.textColor = .black
        restaurantTextView.backgroundColor = .white
        restaurantTextView.layer.borderWidth = 1
        restaurantTextView.layer.borderColor = UIColor.black.cgColor
        restaurantTextView.isEditable = false
        contentView.addSubview(restaurantTextView)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            restaurantTextView.topAnchor.constraint(equalTo: contentView.topAnchor),
            restaurantTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            restaurantTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            restaurantTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    func configure(for restaurant: Restaurant) {
        restaurantTextView.text = "\(restaurant.name)\n\(restaurant.type)\n\(restaurant.time)\n\(restaurant.cost)"
    }
}
