//
//  HomeVC.swift
//  Netflix Clone
//
//  Created by Rituraj Mishra on 24/02/22.
//

import UIKit

class HomeVC: UIViewController
{
    //MARK: -Table view initilization
    private let tableView: UITableView = {
       
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: -Section Titles
    let sectionTitles: [String] = ["Trending Movies","Trending Tv","Popular","Upcoming Movies", "Top Rated"]
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        tableView.tableHeaderView = headerView
        
        configureNavBar()
        getTrendingMovies()
        getTrendingTv()
        getUpcoming()
        getPopular()
        getTopRated()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
     
}

//MARK: -Table view Extension
extension HomeVC: UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18,weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y,
                                         width: 100,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
}

//MARK: -Extension
extension HomeVC
{
    private func configureNavBar()
    {
        var logoImage = UIImage(named: "nlogo")
        logoImage = logoImage?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoImage, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    //MARK: Get Trending Movies
    private func getTrendingMovies()
    {
        ApiCaller.shared.getTrendingMovies { results in
            
            switch results{
            case .success(let movies):
                print(movies)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: Get Trending Movies
    private func getTrendingTv()
    {
        ApiCaller.shared.getTrendingTvs { results in
            
            switch results{
            case .success(let tv):
                print(tv)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getUpcoming()
    {
        ApiCaller.shared.getUpcoming{ results in
            
            switch results{
            case .success(let movies):
                print(movies)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getPopular()
    {
        ApiCaller.shared.getPopular{ results in
            
            switch results{
            case .success(let movies):
                print(movies)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getTopRated()
    {
        ApiCaller.shared.getTopRated{ results in
            
            switch results{
            case .success(let movies):
                print(movies)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
