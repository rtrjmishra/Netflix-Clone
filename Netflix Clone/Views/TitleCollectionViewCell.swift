//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Rituraj Mishra on 25/02/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell
{
    
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        posterImageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configure(with model: String)
    {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
