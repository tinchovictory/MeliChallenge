//
//  InfoView.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class InfoView: UIView {

    private let item: Item
    
    // MARK: Views
    private lazy var condition: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = UIColor.secondaryTextColor
        lbl.text = "\(item.condition.capitalized) - \(item.quantity) Remaining"
        return lbl
    }()
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        lbl.numberOfLines = 0
        lbl.text = item.title
        return lbl
    }()
    
    private lazy var price: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        lbl.text = "$ \(item.price)"
        return lbl
    }()
    
    private let buyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = UIColor.white
        btn.backgroundColor = UIColor.secondaryColor
        btn.setTitle("Buy", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    // MARK: Initializers
    required init(item: Item) {
        self.item = item
        super.init(frame: CGRect.zero)

        self.addSubview(condition)
        self.addSubview(title)
        self.addSubview(price)
        self.addSubview(buyBtn)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupLayout() {
        let borderPadding = CGFloat(20)

        NSLayoutConstraint.activate([
            condition.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: borderPadding),
            condition.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: borderPadding),
            condition.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -borderPadding),
            
            title.topAnchor.constraint(equalTo: condition.bottomAnchor, constant: 15),
            title.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: borderPadding),
            title.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -borderPadding),
            
            price.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
            price.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: borderPadding),
            price.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -borderPadding),
            
            buyBtn.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 25),
            buyBtn.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: borderPadding),
            buyBtn.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -borderPadding),
            buyBtn.heightAnchor.constraint(equalToConstant: 50),
            buyBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -borderPadding)
        ])
    }

}

