//
//  PickLocationController.swift
//  collexapp
//
//  Created by Lex on 23/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class PickLocationController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D!
    var previousController: UIViewController!
    var googleMapView: GMSMapView!
    var googlePlacesClient: GMSPlacesClient!
    var locationPickerImageView: UIImageView!
    
    var likelyPlaces: [GMSPlace] = []
    var selectedLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        setupNavigationItems()
        setupLocationManager()
        updateMapCamera()
    }
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        googlePlacesClient = GMSPlacesClient.shared()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let center = manager.location?.coordinate {
            location = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
        }
    }
    
    private func initialView() {
        let view = PickLocationView(frame: self.view.frame)
        self.view = view
        locationPickerImageView = view.locationPickerImageView
        googleMapView = view.mapView
        googleMapView.isMyLocationEnabled = true
        googleMapView.setMinZoom(11, maxZoom: 17)
    }
    
    private func updateMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(0.5, forKey: kCATransactionAnimationDuration)
        var updateLocaiton: CLLocationCoordinate2D!
        if selectedLocation != nil {
            updateLocaiton = selectedLocation
        } else {
            updateLocaiton = location
        }
        googleMapView.animate(with: GMSCameraUpdate.setTarget(updateLocaiton))
        googleMapView.animate(toZoom: 14)
        CATransaction.commit()
    }
    
    @IBAction func handleDismiss(_ sender: Any?) {
        locationManager.stopUpdatingLocation()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSave(_ sender: Any?) {
        let coordinate = googleMapView.projection.coordinate(for: googleMapView.center)
        let currentLocation = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        if let viewController = previousController as? CreateController {
            viewController.selectedLocation = currentLocation
        }
        print("Get center location lat & long: \(currentLocation)")
        locationManager.stopUpdatingLocation()
        self.dismiss(animated: true, completion: nil)
    }
    
    
//    private func getGooglePlaces() {
//        googlePlacesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
//            if let error = error {
//                print("Current Place error: \(error.localizedDescription)")
//                return
//            }
//            if let likelihoodList = placeLikelihoods {
//                print("Check count \(likelihoodList.likelihoods.count)")
//                for likelihood in likelihoodList.likelihoods {
//                    let place = likelihood.place
//                    print("Check append place: \(place)")
//                    self.likelyPlaces.append(place)
//                }
//            }
//        })
//    }
    
    func setupNavigationItems() {
        setupTitleNavItem()
        setupLeftNavItem()
        setupRightNavItem()
    }
    
    private func setupTitleNavItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Location"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    private func setupLeftNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ArrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(PickLocationController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
    
    private func setupRightNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PickLocationController.handleSave(_:)))
    }
    


}
