//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Rituraj Mishra on 24/02/22.
//

import UIKit
class HeroHeaderUIView: UIView
{
    //MARK: -Header image
    private let heroImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.image = UIImage(named: "poster")
        return image
    }()
    
    //MARK: -Play button
    private let playBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Play", for: .normal)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    //MARK: -Play button
    private let downloadBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Download", for: .normal)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    override init(frame: CGRect)
    {
        super .init(frame: frame)
        
        addSubview(heroImageView)
        addGradient()
        
        addSubview(playBtn)
        addSubview(downloadBtn)
        
        applyConstraints()
    }
    
    override func layoutSubviews()
    {
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -ALl extra functions
extension HeroHeaderUIView
{
    private func addGradient()
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func applyConstraints()
    {
        NSLayoutConstraint.activate([
            playBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            playBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playBtn.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            downloadBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            downloadBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadBtn.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    public func configure(with model: TitleViewModel)
    {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else {return}
        
        heroImageView.sd_setImage(with: url, completed: nil)
    }
}
