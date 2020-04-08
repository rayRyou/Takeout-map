//
//  DataManager.swift
//  AdditionalTimes
//
//  Created by Ryou on 2020/01/31.
//  Copyright © 2020 Ryou. All rights reserved.
//

import UIKit
import CoreLocation

class DataManager: NSObject {
    var spotArray:[Spot] = Array()
    var categoryArray:[String] = Array()

    // user data.
    static var shared:DataManager = {
        return DataManager()
    }()
    
    override init() {
        super.init()
    }
    
    func loadSpotData(url:String!){
        if let url = URL(string: url) {
            do {
                let str = try String(contentsOf: url)
                if let data = str.data(using: .utf8) {
                    let spotInfoArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Array<Dictionary<String,Any>>
                    self.spotArray.removeAll()
                    for spotInfo in spotInfoArray {
                        let spot = Spot()
                        spot.name = spotInfo[Common.KeySpotName] as? String
                        spot.text = spotInfo[Common.KeyText] as? String
                        spot.tel = spotInfo[Common.KeyTel] as? String
                        spot.address = spotInfo[Common.KeyAddress] as? String
                        spot.urlStr = spotInfo[Common.KeyUrl] as? String
                        spot.imageUrl = spotInfo[Common.KeyImageUrl] as? String
                        let lat:CLLocationDegrees? = spotInfo[Common.KeyLatitude] as? CLLocationDegrees
                        let lng:CLLocationDegrees? = spotInfo[Common.KeyLongitude] as? CLLocationDegrees
                        if lat != nil && lng != nil {
                            let coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
                            spot.coordinate = coordinate
                        }
                        spotArray.append(spot)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    class func searchArray(searchText:String)->Array<Spot>!{
        var resultArray:[Spot] = Array()
        for spot in DataManager.shared.spotArray {
            var isFound:Bool = false
            if spot.name.contains(searchText){
                isFound = true
            }else if spot.address.contains(searchText) {
                isFound = true
            }else if spot.tel?.contains(searchText) ?? false {
                isFound = true
            }else if spot.text?.contains(searchText) ?? false {
                isFound = true
            }
            if isFound {
                resultArray.append(spot)
            }
        }
        return resultArray
    }
}
class Spot : NSObject {
    var name:String!
    var address:String!
    var tel:String?
    var mail:String?
    var imageUrl:String?
    var open:[String]?
    var category:String?
    var text:String?
    var urlStr:String?
    var itemArray:[Item]?
    var coordinate:CLLocationCoordinate2D?
}
class Item : NSObject {
    var name:String!
    var price:Int?
    var text:String?
    var imageUrl:String?
}
