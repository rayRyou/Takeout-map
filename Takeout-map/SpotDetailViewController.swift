//
//  SpotDetailViewController.swift
//  Takeout-map
//
//  Created by Ryou on 2020/04/06.
//  Copyright © 2020 Ryou. All rights reserved.
//

import UIKit

class SpotDetailViewController: UIViewController {
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let textLabel = UITextView()
    let telLabel = UITextView()
    let urlLabel = UITextView()
    let addressLabel = UITextView()
    
    let imageView = UIImageView()
    var spot:Spot!
    init(data:Spot) {
        super.init(nibName: nil, bundle: nil)
        self.spot = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = scrollView
        self.view.backgroundColor = .systemBackground
        if spot.imageUrl != nil {
            self.view.addSubview(imageView)
        }
        addressLabel.dataDetectorTypes = .address
        telLabel.dataDetectorTypes = .phoneNumber
        urlLabel.dataDetectorTypes = .all
        textLabel.dataDetectorTypes = .all

        let fontSize:CGFloat = 15.0
        titleLabel.font = Common.FontHiraginoW6
        addressLabel.font = Common.FontHiraginoW6?.withSize(fontSize)
        telLabel.font = Common.FontHiraginoW6?.withSize(fontSize)
        urlLabel.font = Common.FontHiraginoW6?.withSize(fontSize)
        textLabel.font = Common.FontHiraginoW3?.withSize(fontSize)
        
        titleLabel.text = self.spot.name
        addressLabel.text = self.spot.address
        telLabel.text = self.spot.tel
        textLabel.text = self.spot.text
        
        addressLabel.isEditable = false
        telLabel.isEditable = false
        textLabel.isEditable = false
        
        
        if self.spot.urlArray != nil {
            var urls = ""
            for urlStr in self.spot.urlArray! {
                if urls.count > 0 {
                    urls += "\n"
                }
                urls += urlStr
            }
            urlLabel.text = urls
        }
        

        self.view.addSubview(titleLabel)
        self.view.addSubview(addressLabel)
        self.view.addSubview(telLabel)
        self.view.addSubview(urlLabel)
        self.view.addSubview(textLabel)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setPosition()
    }
    func setPosition(){
        let margin:CGFloat = 10.0
        let width:CGFloat = self.view.frame.width
        let height:CGFloat = 40.0
        var posY:CGFloat = 0.0
        if spot.imageUrl != nil {
            imageView.frame = CGRect(x: 0.0, y: 0.0, width: width, height: width/4*3)
            posY += imageView.frame.height + margin
        }else{
            posY = self.scrollView.safeAreaInsets.top + margin
        }
        titleLabel.frame = CGRect(x: margin, y: posY, width: width - margin*2, height: height)
        titleLabel.sizeToFit()
        posY += titleLabel.frame.height + margin
        
        addressLabel.frame = CGRect(x: margin, y: posY, width: width - margin*2, height: height)
        addressLabel.sizeToFit()
        posY += addressLabel.frame.height + margin

        telLabel.frame = CGRect(x: margin, y: posY, width: width - margin*2, height: height)
        telLabel.sizeToFit()
        posY += telLabel.frame.height + margin

        if spot.urlArray?.count ?? 0 > 0{
            urlLabel.frame = CGRect(x: margin, y: posY, width: width - margin*2, height: height)
            urlLabel.sizeToFit()
            posY += urlLabel.frame.height + margin
        }
        
        textLabel.frame = CGRect(x: margin, y: posY, width: width - margin*2, height: height)
        textLabel.sizeToFit()
        posY += textLabel.frame.height + margin
        
        self.scrollView.contentSize = CGSize(width: width, height: posY)

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
