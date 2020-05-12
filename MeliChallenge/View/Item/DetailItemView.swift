//
//  DetailItemView.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class DetailItemView: UIView {
    
    private let item: Item
    
    // MARK: Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.grayBg
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var picture: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.backgroundColor = UIColor.white
        img.image = item.picture
        return img
    }()
    
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
    
    private let descriptionContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = item.description
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: Initializers
    required init(item: Item) {
        self.item = item
        super.init(frame: CGRect.zero)
        
        self.addSubview(scrollView)

        scrollView.addSubview(picture)
        scrollView.addSubview(condition)
        scrollView.addSubview(title)
        scrollView.addSubview(price)
        scrollView.addSubview(buyBtn)
        scrollView.addSubview(descriptionContainer)
        descriptionContainer.addSubview(descriptionLbl)
        
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupLayout() {
        let borderPadding = CGFloat(20)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            picture.topAnchor.constraint(equalTo: scrollView.topAnchor),
            picture.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            picture.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            picture.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            picture.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            condition.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: borderPadding),
            condition.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor, constant: borderPadding),
            condition.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: -borderPadding),
            
            title.topAnchor.constraint(equalTo: condition.bottomAnchor, constant: 15),
            title.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor, constant: borderPadding),
            title.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: -borderPadding),
            
            price.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
            price.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor, constant: borderPadding),
            price.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: -borderPadding),

            buyBtn.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 25),
            buyBtn.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor, constant: borderPadding),
            buyBtn.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: -borderPadding),
            buyBtn.heightAnchor.constraint(equalToConstant: 60),
            
            descriptionContainer.topAnchor.constraint(equalTo: buyBtn.bottomAnchor, constant: 40),
            descriptionContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            descriptionContainer.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            descriptionContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            descriptionLbl.topAnchor.constraint(equalTo: descriptionContainer.topAnchor, constant: 30),
            descriptionLbl.leftAnchor.constraint(equalTo: descriptionContainer.leftAnchor, constant: borderPadding),
            descriptionLbl.rightAnchor.constraint(equalTo: descriptionContainer.rightAnchor, constant: -borderPadding),
            descriptionLbl.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: -30),
        ])
    }
}
