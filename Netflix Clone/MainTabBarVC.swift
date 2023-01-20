//
//  MainTabBarVC.swift
//  Netflix Clone
//
//  Created by Rituraj Mishra on 24/03/22.
//

import UIKit

class MainTabBarVC: UITabBarController{

    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //MARK: Tab bars declaration
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: UpcomingVC())
        let vc3 = UINavigationController(rootViewController: SearchVC())
        let vc4 = UINavigationController(rootViewController: DownloadsVC())
        
        //MARK: -Tab bar image and title name and colour
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.title = "Home"
        
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc2.title = "Upcoming"
        
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.title = "Top Search"
        
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        vc4.title = "Downloads"
        
        tabBar.tintColor = .label
        
        //MARK: -Setting up tab bars
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }


}

