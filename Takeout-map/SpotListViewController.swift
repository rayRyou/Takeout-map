//
//  SpotListViewController.swift
//  Takeout-map
//
//  Created by Kirie Miyajima on 2020/04/21.
//  Copyright © 2020 Ryou. All rights reserved.
//

import Foundation
import UIKit

class SpotListViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var searchedSpotArray:Array<Spot>?
    let searchBar = UISearchBar()
    
    let spotListTableView:UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Common.LightColor
        
        let width = self.view.frame.width
        let height = self.view.frame.height
                
        //table view settings
        spotListTableView.frame = CGRect(x: 0, y: 44, width: width, height: height-44)
        spotListTableView.delegate = self
        spotListTableView.dataSource = self
        spotListTableView.backgroundColor = Common.LightColor
        
        self.view.addSubview(spotListTableView)
            
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchedSpotArray != nil {
            return self.searchedSpotArray?.count ?? 0
        }else{
            return DataManager.shared.spotArray.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        searchBar.placeholder = "検索ワードを入力してください"
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = Common.LightColor
        searchBar.backgroundColor = Common.LightColor
        searchBar.searchTextField.backgroundColor = .systemBackground
        return searchBar
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "spot-cell")

        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "spot-cell")
        }
        
        
        var spot = DataManager.shared.spotArray[indexPath.row]
        if self.searchedSpotArray?.count ?? 0 > 0 {
            spot = self.searchedSpotArray![indexPath.row]
        }
        
        cell?.textLabel?.text = spot.name
        cell?.textLabel?.font = Common.FontHiraginoW6
        
        cell?.detailTextLabel?.text = spot.text
        
        
        cell?.backgroundColor = Common.LightColor
        cell?.textLabel?.textColor = .black
        cell?.detailTextLabel?.textColor = .black
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var spot = DataManager.shared.spotArray[indexPath.row]
        if self.searchedSpotArray?.count ?? 0 > 0 {
            spot = self.searchedSpotArray![indexPath.row]
        }
        let detailVC = SpotDetailViewController(data: spot)
        self.tabBarController?.present(detailVC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           var resultArray:[Spot] = DataManager.searchArray(searchText: searchText)
           if searchText.count < 1 {
               self.searchedSpotArray = nil
           }else{
               self.searchedSpotArray = resultArray
           }
           self.spotListTableView.reloadData()
       }
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder()
       }
    
    
    
}


