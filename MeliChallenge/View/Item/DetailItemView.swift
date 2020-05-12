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
        if let itemImg = item.picture {
            img.image = itemImg
        } else {
            img.image = UIImage(named: "noImg")
        }
        return img
    }()

    private lazy var infoView: InfoView = {
        let infoView = InfoView(item: item)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
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
        lbl.textColor = .black
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
        scrollView.addSubview(infoView)

        if self.item.description != nil {
            scrollView.addSubview(descriptionContainer)
        }
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
            
            infoView.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: borderPadding),
            infoView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            infoView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),

            descriptionLbl.topAnchor.constraint(equalTo: descriptionContainer.topAnchor, constant: 30),
            descriptionLbl.leftAnchor.constraint(equalTo: descriptionContainer.leftAnchor, constant: borderPadding),
            descriptionLbl.rightAnchor.constraint(equalTo: descriptionContainer.rightAnchor, constant: -borderPadding),
            descriptionLbl.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: -30),
        ])
        
        if self.item.description == nil {
            NSLayoutConstraint.activate([
                infoView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                descriptionContainer.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 40),
                descriptionContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
                descriptionContainer.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
                descriptionContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            ])
        }
    }
    
}
