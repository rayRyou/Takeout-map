//
//  MapViewController.swift
//  takeout-map
//
//  Created by Ryou on 2020/04/05.
//  Copyright © 2020 Ryou. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {
    var mapView = MKMapView()
    var searchBar = UISearchBar()
    var searchedSpotArray:Array<Spot>?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mapView
        mapView.delegate = self
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: Common.DefaultMapSpan, longitudeDelta: Common.DefaultMapSpan)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: Common.DefaultMapCenter, span: span)
        mapView.region = region
        searchBar.placeholder = "検索ワードを入力してください"
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = Common.LightColor
        searchBar.searchTextField.backgroundColor = .systemBackground
        searchBar.delegate = self
        self.view.addSubview(searchBar)
        if self.searchedSpotArray != nil {
            dropSpotPins(spotArray: self.searchedSpotArray)
        }else{
            dropSpotPins(spotArray: DataManager.shared.spotArray)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.frame = CGRect(x: 0.0, y: self.view.safeAreaInsets.top, width: self.view.frame.width, height: 40.0)
    }
    func createAnnotation(spot:Spot, coordinate:CLLocationCoordinate2D?)->MKAnnotation{
        let ann = SpotAnnotation()
        if coordinate != nil {
            ann.coordinate = coordinate!
        }else{
            ann.coordinate = spot.coordinate!
        }
        ann.title = spot.name
        ann.subtitle = spot.text
        ann.spotData = spot
        return ann
    }
    func dropSpotPin(spot:Spot!) {
        if spot.coordinate != nil {
            let annotation = self.createAnnotation(spot: spot, coordinate: spot.coordinate)
            self.mapView.addAnnotation(annotation)
        }else if spot.address != nil {
            CLGeocoder().geocodeAddressString(spot.address) { placemarks, error in
                if let loc = placemarks?.first?.location {
                    let annotation = self.createAnnotation(spot: spot, coordinate: loc.coordinate)
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    func dropSpotPins(spotArray:[Spot]!){
        for spot in spotArray {
            self.dropSpotPin(spot: spot)
        }
    }

}
extension MapViewController:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
          // ユーザの現在地の青丸マークは置き換えない
          return nil
        }
        let identifier = "Pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKAnnotationView
        if annotationView == nil {
//            annotationView = MKMarkerAnnotationView.init(annotation: annotation, reuseIdentifier: identifier)
            annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView!.annotation = annotation
        annotationView!.tintColor = Common.TextColor
        annotationView!.canShowCallout = true
        if annotationView is MKMarkerAnnotationView {
            let markerView = annotationView as! MKMarkerAnnotationView
            markerView.animatesWhenAdded = true
            markerView.titleVisibility = .visible
            markerView.subtitleVisibility = .hidden
            markerView.markerTintColor = Common.BaseColor
            markerView.glyphImage = UIImage(named: Common.TakeoutIcon)
            markerView.displayPriority = .required
        }else{
            annotationView?.image = UIImage(named: Common.TakeoutIcon)?.resizeImage(CGSize(width: Common.MapPinSize, height: Common.MapPinSize))
//            annotationView?.backgroundColor = Common.BaseColor
//            annotationView?.layer.cornerRadius = Common.MapPinSize * 0.5
            annotationView?.rightCalloutAccessoryView = UIButton(type: .infoDark)
        }

        return annotationView!
        
    }
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for pin in views {
            pin.transform = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
            UIView.animate(withDuration: 0.25, animations: {
                pin.alpha = 1.0
                pin.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            }) { (finish) in
                UIView.animate(withDuration: 0.25) {
                    pin.transform = CGAffineTransform.identity
                }
            }
        }
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.searchBar.resignFirstResponder()
    }
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.searchBar.resignFirstResponder()
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.searchBar.resignFirstResponder()
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.searchBar.resignFirstResponder()
        let spotAnn = view.annotation as? SpotAnnotation
        let spot = spotAnn?.spotData
        let detailVC = SpotDetailViewController(data: spot!)
        self.tabBarController?.present(detailVC, animated: true, completion: nil)
    }
}
extension MapViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var resultArray:[Spot] = DataManager.searchArray(searchText: searchText)
        if searchText.count < 1 {
            self.searchedSpotArray = nil
        }else{
            self.searchedSpotArray = resultArray
        }
        self.mapView.removeAnnotations(self.mapView.annotations)
        if self.searchedSpotArray != nil {
            dropSpotPins(spotArray: self.searchedSpotArray)
        }else{
            dropSpotPins(spotArray: DataManager.shared.spotArray)
        }
    }
}
