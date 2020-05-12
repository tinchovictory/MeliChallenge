//
//  ResultsTableViewCell.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    var resultItem: ResultItem? {
        didSet {
            thumbnail.image = resultItem?.thumbnail
            title.text = resultItem?.title
            price.text = nil
            if let priceVal = resultItem?.price {
                price.text = "$ \(priceVal)"
            }
        }
    }
    
    // MARK: Views
    private let thumbnail: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    private let title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let price: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        lbl.textColor = .black
        return lbl
    }()
    
    // MARK: Iniializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.backgroundColor = .white
        
        // set the line separator to full width
        self.separatorInset = UIEdgeInsets.zero
     
        // add child views
        contentView.addSubview(thumbnail)
        contentView.addSubview(title)
        contentView.addSubview(price)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Layout
    private func setupLayout() {
        
        let thumbnailHeightConstraint = thumbnail.heightAnchor.constraint(equalToConstant: 130)
        // reduce the height prioirty to avoid warnings when not displaying images
        thumbnailHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            thumbnail.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            thumbnail.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35),
            thumbnail.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            thumbnailHeightConstraint,

            title.topAnchor.constraint(equalTo: thumbnail.topAnchor),
            title.leftAnchor.constraint(equalTo: thumbnail.rightAnchor, constant: 10),
            title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),

            price.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            price.leftAnchor.constraint(equalTo: title.leftAnchor),
            price.rightAnchor.constraint(equalTo: title.rightAnchor),
            price.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
}
