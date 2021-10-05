//
//  HomeView.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(productCollectionView)
        productCollectionView.snp.makeConstraints { (make) in
            make.top.bottom.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
            make.left.right.lessThanOrEqualTo(self)
        }
        addSubview(friendlyLabel)
        friendlyLabel.snp.makeConstraints{ (make) in
            make.left.right.equalTo(productCollectionView).inset(35)
            make.centerX.centerY.equalTo(productCollectionView)
        }
        addSubview(universityButton)
        universityButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(50)
            make.centerX.equalTo(self)
            make.height.equalTo(30)
            make.left.right.lessThanOrEqualTo(self)
        }
        universityButton.addSubview(gpsImageView)
        gpsImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(universityButton)
            make.height.width.equalTo(25)
            make.left.lessThanOrEqualTo(universityButton).inset(10)
        }
    }
    
    let productCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.collexapp.mainLightWhite
        collectionView.allowsSelection = true
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    let friendlyLabel: UILabel = {
        let label = UILabel()
//        label.text = "Wow, such empty, please choose another university"
        label.font = UIFont(name: "FiraSans-Bold", size: 15)
        label.textColor = UIColor.collexapp.mainBlack
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    let universityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.collexapp.mainLightWhite
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 45, bottom: 0, right: 10)
        button.setTitle("Assumption University | City Campus", for: .normal)
        button.setTitleColor(UIColor.collexapp.mainBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 15)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
        button.addTarget(self, action: #selector(HomeController.handleUniversity(_:)), for: .touchUpInside)
        return button
    }()
    
    let gpsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "LocationGPS").withRenderingMode(.alwaysOriginal)
        return imageView
    }()
}
