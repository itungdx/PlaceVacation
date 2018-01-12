//
//  HomeViewController.swift
//  PlaceVacation
//
//  Created by Tung Xuan on 1/11/18.
//  Copyright © 2018 Tung Xuan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces



class HomeViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    
//    var viewMap: GMSMapView?
//    var placePreviewView: PlacePreviewView?
//
//    let currentLocationMarker = GMSMarker()
//    var locationManager = CLLocationManager()
//
//    let customMarkerWidth: Int = 50
//    let customMarkerHeight: Int = 70
    
    let previewDemoData = [(title: "Bo Da Pagoda", img: #imageLiteral(resourceName: "Place_BoDaPagoda"), text: "Bo Da"), (title: "Vinh Nghiem Pagoda", img: #imageLiteral(resourceName: "Place_VinhNghiemPagoDa") , text: "Bo Da"), (title: "Waterfall Suoi Mo", img: #imageLiteral(resourceName: "Place_WaterfallSuoiMo"), text: "Bo Da" )]
    let localtion = [(lat: 21.242810, long: 106.052629),(lat:  21.213664, long: 106.324355),(lat:  21.266104, long: 106.485242)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        
        placePreviewView=PlacePreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 190))
        self.view.addSubview(btnMyLocation)
                btnMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive=true
                btnMyLocation.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive=true
                btnMyLocation.widthAnchor.constraint(equalToConstant: 50).isActive=true
                btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
        
        //viewMap = initMapView()
        //setupViews()
        initGoogleMaps()
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {

        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    

    // Chay lien tuc
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 18)
        
        mapView.animate(to: camera)

    }
    
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        print("position ")
//    }
    
    // MARK: GOOGLE MAP DELEGATE
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 50, height: 70), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
        
        marker.iconView = customMarker
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
        let data = previewDemoData[customMarkerView.tag]
        placePreviewView.setData(title: data.title, img: data.img)
        return placePreviewView
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let tag = customMarkerView.tag
        placeTapped(tag: tag)
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 70, height: 70), image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag)
        marker.iconView = customMarker
    }
    
    var placePreviewView: PlacePreviewView = {
        let v = PlacePreviewView()
        return v
    }()
    
    func initGoogleMaps() {

        for i in 0...localtion.count - 1 {

            let marker = GMSMarker()

            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 50, height: 70), image: previewDemoData[i].img, borderColor: UIColor.darkGray, tag: i)
            marker.iconView=customMarker

            marker.position = CLLocationCoordinate2D(latitude: localtion[i].lat, longitude:localtion[i].long)
            marker.title = previewDemoData[i].title
            marker.map = self.mapView
        }

    }


    @objc func placeTapped(tag: Int) {
        let v=DetailVC()
        v.passedData = previewDemoData[tag]
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    @objc func btnMyLocationAction() {
        let location: CLLocation? = mapView.myLocation
        if location != nil {
            mapView.animate(toLocation: (location?.coordinate)!)
            let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17)
            mapView.animate(to: camera)
        }
    }
    
    let btnMyLocation: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.white
        btn.setImage(#imageLiteral(resourceName: "my_location"), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor=UIColor.gray
        btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()

}
