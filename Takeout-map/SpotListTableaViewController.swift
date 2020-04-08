//
//  ShopListTableaViewController.swift
//  takeout-map
//
//  Created by Ryou on 2020/04/05.
//  Copyright © 2020 Ryou. All rights reserved.
//

import UIKit

class SpotListTableaViewController: UITableViewController {
    var searchedSpotArray:Array<Spot>?
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Common.LightColor

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.searchedSpotArray != nil {
            return self.searchedSpotArray?.count ?? 0
        }else{
            return DataManager.shared.spotArray.count
        }
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        searchBar.placeholder = "検索ワードを入力してください"
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = Common.LightColor
        searchBar.searchTextField.backgroundColor = .systemBackground
        return searchBar
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var spot = DataManager.shared.spotArray[indexPath.row]
        if self.searchedSpotArray?.count ?? 0 > 0 {
            spot = self.searchedSpotArray![indexPath.row]
        }
        let detailVC = SpotDetailViewController(data: spot)
        self.tabBarController?.present(detailVC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
}
extension SpotListTableaViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var resultArray:[Spot] = DataManager.searchArray(searchText: searchText)
        if searchText.count < 1 {
            self.searchedSpotArray = nil
        }else{
            self.searchedSpotArray = resultArray
        }
        self.tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
