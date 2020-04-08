//
//  BaseViewController.swift
//  takeout-map
//
//  Created by Ryou on 2020/04/05.
//  Copyright © 2020 Ryou. All rights reserved.
//

import UIKit

class BaseViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = Common.BaseColor
        self.tabBar.barTintColor = Common.BaseColor
        self.tabBar.tintColor = Common.AccentColor
        self.tabBar.unselectedItemTintColor = Common.DarkColor
        
        DataManager.shared.loadSpotData(url: Common.DataUrl)
        let tabIconSize:CGFloat = 25.0
        let mapVC = MapViewController()
        let menuBtn = UITabBarItem(title: "Map", image: UIImage(named: Common.MapIcon)?.resizeImage(CGSize(width: tabIconSize, height: tabIconSize)), tag: 0)
        mapVC.tabBarItem = menuBtn
        
        let listVC = SpotListTableaViewController()
        let litBtn = UITabBarItem(title: "List", image: UIImage(named: Common.ListIcon)?.resizeImage(CGSize(width: tabIconSize, height: tabIconSize)), tag: 1)
        listVC.tabBarItem = litBtn

        
        self.viewControllers = [mapVC, listVC]

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
