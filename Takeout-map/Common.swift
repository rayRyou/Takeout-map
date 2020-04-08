//
//  Common.swift
//  osina-manager
//
//  Created by Ryou on 2018/09/19..
//  Copyright © 2018年 Ryou. All rights reserved.
//

import UIKit
import CoreLocation
class Common: NSObject {
    static let BaseColor = UIColor(red: 255/255.0, green: 241/255.0, blue: 0/255.0, alpha: 1.0)
    static let TextColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    static let LightColor = UIColor(red: 255/255.0, green: 250/255.0, blue: 172/255.0, alpha: 1.0)
    static let DarkColor = UIColor(red: 91/255.0, green: 82/255.0, blue: 0/255.0, alpha: 1.0)
    static let AccentColor = UIColor(red: 215/255.0, green: 10/255.0, blue: 28/255.0, alpha: 1.0)

    static let TabelogColor = UIColor(red: 242/255.0, green: 174/255.0, blue: 61/255.0, alpha: 1.0)
    static let RettyColor = UIColor(red: 241/255.0, green: 164/255.0, blue: 63/255.0, alpha: 1.0)
    static let GurunaviColor = UIColor(red: 201/255.0, green: 42/255.0, blue: 36/255.0, alpha: 1.0)
    
    static let DataUrl = "_YOUR_SPOT_JSON_URL_" // jsonファイルを読み込むURLを入力してください
    static let MapIcon = "icon_map.png"
    static let ListIcon = "icon_list.png"
    static let TakeoutIcon = "icon_takeout.png"

    static let FontHiraginoW3 = UIFont(name: "HiraginoSans-W3", size: 20.0)
    static let FontHiraginoW6 = UIFont(name: "HiraginoSans-W6", size: 20.0)
    
    static let DefaultMapCenter = CLLocationCoordinate2DMake(35.861560, 139.972151)
    static let DefaultMapSpan = 0.005
    static let MapPinSize:CGFloat = 50.0

    // Key String
    static let KeySpotName = "店名"
    static let KeyAddress = "所在地"
    static let KeyTel = "問い合わせ先 (TEL)"
    static let KeyOpenDay = "実施曜日"
    static let KeyText = "メニュー (説明文 or URL) や備考など自由記入"
    static let KeyUrl = "よく情報発信しているSNSのURL"
    static let KeyImageUrl = "写真URL"
    // 所在地をジオコーディングして緯度経度を取得していますが、緯度経度のデータがある場合はこちらが優先されます
    static let KeyLatitude = "緯度" // option
    static let KeyLongitude = "経度" // option

    // beacon ids
    static let ShadowOffset:CGSize = CGSize(width: 0.0, height: 0.0);
    static let ShadowRadius:CGFloat = 2.0;
    static let ShadowOpacity:Float = 0.7;
    static let DateFormat = "yyyy/MM/dd HH:mm"
    
    class func wrongAnimation(textField:UIView){
        UIView.animate(withDuration: 0.0625, delay: 0.0, options: .curveLinear, animations: {
            textField.transform = CGAffineTransform(translationX: -10.0, y: 0.0)
        }, completion: nil)
        UIView.animate(withDuration: 0.0625, delay: 0.0625, options: .curveLinear, animations: {
            textField.transform = CGAffineTransform(translationX: 10.0, y: 0.0)
        }, completion: nil)
        UIView.animate(withDuration: 0.0625, delay: 0.125, options: .curveLinear, animations: {
            textField.transform = CGAffineTransform(translationX: -10.0, y: 0.0)
        }, completion: nil)
        UIView.animate(withDuration: 0.0625, delay: 0.1875, options: .curveLinear, animations: {
            textField.transform = CGAffineTransform(translationX: 10.0, y: 0.0)
        }, completion: nil)
        UIView.animate(withDuration: 0.0625, delay: 0.25, options: .curveLinear, animations: {
            textField.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    static var shared:Common = {
        return Common()
    }()
}
extension UIImage {
    
    func resizeImage(_ size: CGSize) -> UIImage? {
        let widthRatio = size.width / self.size.width
        let heightRatio = size.height / self.size.height
        let rate = (widthRatio < heightRatio) ? widthRatio : heightRatio
        let resizedSize = CGSize(width: (self.size.width * rate), height: (self.size.height * rate))
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 3.0);
        draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    // 比率だけ指定する場合
    func resizeImageWithRate(_ rate: CGFloat) -> UIImage {
        let resizedSize = CGSize(width: Int(self.size.width * rate), height: Int(self.size.height * rate))
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 3.0);
        draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}

