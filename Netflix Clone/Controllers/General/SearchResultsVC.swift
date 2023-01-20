//
//  SearchResultsVC.swift
//  Netflix Clone
//
//  Created by Rituraj Mishra on 25/03/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import UIKit

protocol SearchResultsVCDelegate: AnyObject{
    func searchResultsVCDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultsVC: UIViewController{
    public var titles: [Title] = [Title]()
    
    public weak var delegate: SearchResultsVCDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
}

extension SearchResultsVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as?
                TitleCollectionViewCell else {return UICollectionViewCell()}
        
        cell.configure(with: titles[indexPath.row].poster_path ?? "Unknown!")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        
        ApiCaller.shared.movieWithQuery(with: titleName)
        { [weak self] result in
            
            switch result{
            case .success(let element):
                self?.delegate?.searchResultsVCDidTapItem(TitlePreviewViewModel(title: title.original_title ?? "",
                                                                                youtubeView: element,
                                                                                titleOverview: title.overview ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
