//
//  PickLocationView.swift
//  collexapp
//
//  Created by Lex on 23/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import GoogleMaps
import SnapKit

class PickLocationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(mapView)
        setupGoogleMap()
        addSubview(locationPickerImageView)
        setupLocationPickerImageView()
    }
    
    let mapView: GMSMapView = {
        var defaults = UserDefaults.standard
        var location: CLLocationCoordinate2D!
        var greyModeStyle: GMSMapStyle!
        let updateLocation = defaults.object(forKey: "location")
        if let number = updateLocation as? [String: Double] {
            let latitude = number["latitude"]
            let longitude = number["longitude"]
            if latitude != nil && longitude != nil {
                location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            }
        } else {
            location = CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198)
        }
        let camera = GMSCameraPosition.camera(withTarget: location, zoom: 14)
        let mapview = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        if let file = Bundle.main.url(forResource: "googlemap_style", withExtension: "json") {
            greyModeStyle = try! GMSMapStyle.init(contentsOfFileURL: file)
            mapview.mapStyle = greyModeStyle
        }

        mapview.mapType = .normal
        mapview.setMinZoom(7, maxZoom: 17)
        return mapview
    }()
    
    private func setupGoogleMap() {
        mapView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self)
        }
    }
    
    let locationPickerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "LocationPicker").withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func setupLocationPickerImageView() {
        locationPickerImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(25)
            make.centerX.centerY.equalTo(mapView)
        }
    }

}
