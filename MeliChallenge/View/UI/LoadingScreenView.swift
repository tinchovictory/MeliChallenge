//
//  LoadingScreenView.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class LoadingScreenView: UIView {
    
    private let spinnerView: SpinnerView = {
        let view = SpinnerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.addSubview(spinnerView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinnerView.heightAnchor.constraint(equalToConstant: 80),
            spinnerView.widthAnchor.constraint(equalTo: spinnerView.heightAnchor)
        ])
    }
}
