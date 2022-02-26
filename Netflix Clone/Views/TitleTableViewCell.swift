//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Rituraj Mishra on 25/02/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell
{
    static let identifier = "TitleTableViewCell"
    
    private let  titlePosterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let  titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let  playTitleBtn: UIButton = {
        let btn = UIButton(type: .roundedRect)
        btn.setImage(UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titlePosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleBtn)
        
        applyConstraints()
    }
    
    private func applyConstraints()
    {
        NSLayoutConstraint.activate([
            titlePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            titlePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            titlePosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            titlePosterImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterImageView.trailingAnchor,constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            playTitleBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            playTitleBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    public func configure(with model: TitleViewModel)
    {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else {return}
        
        titlePosterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
