//
//  CheckProductView.swift
//  collexapp
//
//  Created by Lex on 24/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit
import ImageSlideshow
import GoogleMaps

class CheckProductView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(scrollView)
        setupScrollView()
        scrollView.addSubview(checkProductView)
        setupCheckProductView()
        checkProductView.addSubview(productImageSlideShow)
        setupProductImageSlideShow()
        checkProductView.addSubview(informationStackView)
        setupInformationStackView()
        informationStackView.addArrangedSubview(productNameLabel)
        informationStackView.addArrangedSubview(productPriceLabel)
        checkProductView.addSubview(optionButton)
        setupOptionButton()
        checkProductView.addSubview(soldButton)
        setupSoldButton()
        checkProductView.addSubview(productConditionLabel)
        setupProductConditionLabel()
        checkProductView.addSubview(productCategoryLabel)
        setupProductCategoryLabel()
        checkProductView.addSubview(sellerInformationLabel)
        setupSellerInformationLabel()
        checkProductView.addSubview(sellerInformationView)
        setupSellerInformationView()
        sellerInformationView.addSubview(profileImageView)
        setupProfileImageView()
        sellerInformationView.addSubview(profileStackView)
        setupProfileStackView()
        profileStackView.addArrangedSubview(nameLabel)
        profileStackView.addArrangedSubview(universityNameLabel)
        profileStackView.addArrangedSubview(viewMessengerButton)
        checkProductView.addSubview(googleMapView)
        setupGoogleMap()
        checkProductView.addSubview(productDescriptionTextView)
        setupProductDescriptionTextView()
    }

    let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        return scrollview
    }()
    
    private func setupScrollView() {
        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    let checkProductView: UIView = {
        let view = UIView()
        return view
    }()
    
    private func setupCheckProductView() {
        checkProductView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(980)
        }
    }
    
    let productImageSlideShow: ImageSlideshow = {
        let imageSlideShow = ImageSlideshow()
        imageSlideShow.setImageInputs([ImageSource(image: #imageLiteral(resourceName: "DefaultPhoto").withRenderingMode(.alwaysOriginal))])
        imageSlideShow.layer.cornerRadius = 5
        imageSlideShow.layer.borderWidth = 1
        imageSlideShow.layer.borderColor = UIColor.collexapp.mainLightGrey.cgColor
        imageSlideShow.backgroundColor = UIColor.collexapp.mainLightWhite
        imageSlideShow.clipsToBounds = true
        imageSlideShow.zoomEnabled = false
        imageSlideShow.contentScaleMode = .scaleAspectFill
        return imageSlideShow
    }()
    
    //Height 215
    private func setupProductImageSlideShow() {
        productImageSlideShow.snp.makeConstraints { (make) in
            make.top.equalTo(checkProductView).inset(15)
            make.left.right.lessThanOrEqualTo(checkProductView).inset(10)
            make.centerX.equalTo(checkProductView)
            make.height.equalTo(200)
        }
    }
    
    let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.leading
        stackView.distribution = UIStackView.Distribution.fillEqually
        return stackView
    }()
    
    //Height 85
    private func setupInformationStackView() {
        informationStackView.snp.makeConstraints { (make) in
            make.top.equalTo(productImageSlideShow.snp.bottom).offset(15)
            make.centerX.equalTo(checkProductView)
            make.height.equalTo(70)
            make.left.right.equalTo(checkProductView).inset(10)
        }
    }
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Wine"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Bold", size: 17)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    
    let productPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "THB 5,000"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    let optionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "SaveUnselected").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(CheckProductController.handleOption(_:)), for: .touchUpInside)
        return button
    }()
    
    //Height 40 no need
    private func setupOptionButton() {
        optionButton.snp.makeConstraints{ (make) in
            make.top.equalTo(informationStackView.snp.bottom)
            make.right.lessThanOrEqualTo(checkProductView).inset(10)
            make.height.width.equalTo(40)
        }
    }
    
    let soldButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "SoldRedIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(CheckProductController.handleSold(_:)), for: .touchUpInside)
        return button
    }()
    
    //Height 40 no need
    private func setupSoldButton() {
        soldButton.snp.makeConstraints{ (make) in
            make.top.equalTo(informationStackView.snp.bottom)
            make.right.lessThanOrEqualTo(checkProductView).inset(60)
            make.height.width.equalTo(40)
        }
    }
    
    let productConditionLabel: UILabel = {
        let label = UILabel()
        label.text = "Product condition: Good"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    //Height 70
    private func setupProductConditionLabel() {
        productConditionLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(informationStackView.snp.bottom).offset(40)
            make.left.right.lessThanOrEqualTo(checkProductView).inset(10)
            make.centerX.equalTo(checkProductView)
            make.height.equalTo(30)
        }
    }
    
    let productCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Product category: Kitchen"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    //Height 35
    private func setupProductCategoryLabel() {
        productCategoryLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(productConditionLabel.snp.bottom).offset(5)
            make.left.right.lessThanOrEqualTo(checkProductView).inset(10)
            make.centerX.equalTo(checkProductView)
            make.height.equalTo(30)
        }
    }
    
    let sellerInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "Seller Information"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Bold", size: 18)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    //Height 45
    private func setupSellerInformationLabel() {
        sellerInformationLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(productCategoryLabel.snp.bottom).offset(15)
            make.left.right.lessThanOrEqualTo(checkProductView).inset(10)
            make.centerX.equalTo(checkProductView)
            make.height.equalTo(30)
        }
    }
    
    let sellerInformationView: UIView = {
        let view = UIView()
        return view
    }()
    
    //Height 110
    private func setupSellerInformationView() {
        sellerInformationView.snp.makeConstraints { (make) in
            make.top.equalTo(sellerInformationLabel.snp.bottom).offset(10)
            make.left.right.equalTo(checkProductView)
            make.height.equalTo(100)
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ProfileImage").withRenderingMode(.alwaysOriginal)
        imageView.layer.cornerRadius = 70/2
        imageView.clipsToBounds = true
        return imageView
    }()
    

    let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.leading
        stackView.distribution = UIStackView.Distribution.fillEqually
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Lex"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Bold", size: 17)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    
    let universityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Assumption University"
        label.textColor = UIColor.gray
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    let viewMessengerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View messenger", for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 15.5)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.collexapp.mainBlue, for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
        button.addTarget(self, action: #selector(CheckProductController.handleViewMessenger(_:)), for: .touchUpInside)
        return button
    }()
    
    private func setupProfileImageView() {
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(sellerInformationView)
            make.height.width.equalTo(70)
            make.left.lessThanOrEqualTo(sellerInformationView).inset(10)
        }
    }
    
    private func setupProfileStackView() {
        profileStackView.snp.makeConstraints { (make) in
            make.centerY.equalTo(sellerInformationView)
            make.height.equalTo(70)
            make.width.equalTo(self.frame.width - 100)
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.right.equalTo(sellerInformationView).inset(10)
        }
    }
    
    let googleMapView: GMSMapView = {
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
        let camera = GMSCameraPosition.camera(withTarget: location, zoom: 17)
        let mapview = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        if let file = Bundle.main.url(forResource: "googlemap_style", withExtension: "json") {
            greyModeStyle = try! GMSMapStyle.init(contentsOfFileURL: file)
            mapview.mapStyle = greyModeStyle
        }

        mapview.layer.cornerRadius = 5
        mapview.mapType = .normal
        mapview.isUserInteractionEnabled = false
        mapview.setMinZoom(7, maxZoom: 17)
        return mapview
    }()
    
//    Height 210
    private func setupGoogleMap() {
        googleMapView.snp.makeConstraints { (make) in
            make.top.equalTo(sellerInformationView.snp.bottom).offset(10)
            make.left.left.lessThanOrEqualTo(checkProductView).inset(10)
            make.centerX.equalTo(checkProductView)
            make.height.equalTo(200)
        }
    }
    
    let productDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.collexapp.mainBlack
        textView.text = "This is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Japan\nThis is the best wine from Korean"
        textView.font = UIFont(name: "FiraSans-Regular", size: 16)
        textView.backgroundColor = UIColor.clear
        textView.isScrollEnabled = true
        return textView
    }()

    //Height 210
    private func setupProductDescriptionTextView() {
        productDescriptionTextView.snp.makeConstraints{ (make) in
            make.top.equalTo(googleMapView.snp.bottom).offset(10)
            make.left.right.lessThanOrEqualTo(checkProductView).inset(10)
            make.centerX.equalTo(checkProductView)
            make.height.equalTo(200)
        }
    }
}
