//
//  FilterCollectionViewCell.swift
//  vmc49_p5
//
//  Created by Victor Chen on 3/31/19.
//  Copyright © 2019 Victor Chen. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    var filterLabel: UILabel!
    var isselected: Bool!
    
    let fontSize: CGFloat = 14
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterLabel = UILabel(frame: .zero)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.font = UIFont.systemFont(ofSize: fontSize)
        filterLabel.textAlignment = .center
        filterLabel.layer.borderWidth = 1
        filterLabel.layer.borderColor = UIColor.white.cgColor
        contentView.addSubview(filterLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    func configure(for filter: Filter) {
        filterLabel.text = filter.name
        changeColor(for: filter)
    }
    
    func changeState(for filter: Filter) {
        changeColor(for: filter)
        if !filter.isSelected {
            filter.isSelected = true
        }
        else {
            filter.isSelected = false
        }
    }
    
    func changeColor(for filter: Filter) {
        if filter.isSelected {
            filterLabel.backgroundColor = .blue
            filterLabel.textColor = .white
        }
        else {
            filterLabel.backgroundColor = .white
            filterLabel.textColor = .blue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
