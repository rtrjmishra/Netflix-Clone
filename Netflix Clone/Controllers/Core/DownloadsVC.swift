//
//  DownloadsVC.swift
//  Netflix Clone
//
//  Created by Rituraj Mishra on 24/03/22.
//

import UIKit

class DownloadsVC: UIViewController{
    
    private let downloadedTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private var titles: [TitleItem] = [TitleItem]()
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(downloadedTable)
        
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        
        fetchLocalStorage()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil) { _  in
            self.fetchLocalStorage()
        }
    }
    
    private func fetchLocalStorage(){
        DataPersistenceManager.shared.fetchingTitlesFromDatabase { [weak self] result in
            switch result{
            case .success(let title):
                self?.titles = title
                DispatchQueue.main.async {
                    self?.downloadedTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews(){
        view.layoutSubviews()
        downloadedTable.frame = view.bounds
    }
}

extension DownloadsVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell
        else {return UITableViewCell()}
        
        cell.configure(with: TitleViewModel(titleName: titles[indexPath.row].original_title ?? titles[indexPath.row].original_name ?? "Unknown title Name",posterURL: titles[indexPath.row].poster_path ??  "Unknown poster path"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        switch editingStyle{
            case .delete:
                DataPersistenceManager.shared.deleteTitle(model: titles[indexPath.row]) { [weak self] result in
                    switch result{
                    case .success():
                        print("Deleted from database!")
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                self.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_title else {return}
        ApiCaller.shared.movieWithQuery(with: titleName)
        { [weak self] result in
            switch result{
            case .success(let element):
                DispatchQueue.main.async{
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
