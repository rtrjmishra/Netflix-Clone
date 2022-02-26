//
//  SearchVC.swift
//  Netflix Clone
//
//  Created by Rituraj Mishra on 24/02/22.
//

import UIKit

class SearchVC: UIViewController
{
    private let discoverTable: UITableView = {
       
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private var titles: [Title] = [Title]()
    
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsVC())
        search.searchBar.placeholder = "Search here for anything.."
        search.searchBar.searchBarStyle = .minimal
        return search
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(discoverTable)
        discoverTable.dataSource = self
        discoverTable.delegate = self
        
        fetchDiscoverMovies()
        
        searchController.searchResultsUpdater = self
        
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
        
    }
    
    private func fetchDiscoverMovies()
    {
        ApiCaller.shared.getDiscoverMovies { [weak self] result in
            switch(result)
            {
            case .success(let title):
                self?.titles = title
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension SearchVC: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as?
                TitleTableViewCell else {return UITableViewCell()}
        
        cell.configure(with: TitleViewModel(titleName: titles[indexPath.row].original_title ?? titles[indexPath.row].original_name ?? "Unknown title Name",posterURL: titles[indexPath.row].poster_path ??  "Unknown poster path"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_title else {return}
        
        ApiCaller.shared.movieWithQuery(with: titleName) { [weak self] result in
            
            switch result{
            case .success(let element):
                DispatchQueue.main.async
                {
                    let vc = TitlePreviewVC()
                    vc.configure(with: TitlePreviewViewModel(title: titleName,
                                                             youtubeView: element,
                                                             titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension SearchVC: UISearchResultsUpdating,SearchResultsVCDelegate
{
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsVC = searchController.searchResultsController as? SearchResultsVC else {return}
        
        resultsVC.delegate = self
        
        ApiCaller.shared.search(with: query) { result in
            DispatchQueue.main.async
            {
                switch result{
                case .success(let title):
                    resultsVC.titles = title
                    resultsVC.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchResultsVCDidTapItem(_ viewModel: TitlePreviewViewModel)
    {
        DispatchQueue.main.async
        { [weak self] in
            let vc = TitlePreviewVC()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
