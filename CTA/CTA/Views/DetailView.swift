//
//  DetailView.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    public lazy var picture: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(systemName: "photo")
        picture.contentMode = .scaleAspectFit
        return picture
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Description Label"
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Title Label"
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit() {
        configurePicture()
        configurTitleLabel()
        configureDescriptionLabel()
        configureButton()
    }
    
    private func configurePicture() {
        addSubview(picture)
        picture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            picture.leadingAnchor.constraint(equalTo: leadingAnchor),
            picture.trailingAnchor.constraint(equalTo: trailingAnchor),
            picture.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func configurTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
        ])
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }
    
    private func configureButton() {
        addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            favoriteButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

}



