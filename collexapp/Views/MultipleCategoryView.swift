//
//  MultipleCategoryView.swift
//  collexapp
//
//  Created by Lex on 5/9/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit

class MultipleCategoryView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints { (make) in
            make.top.bottom.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
            make.left.right.lessThanOrEqualTo(self)
        }
        addSubview(friendlyLabel)
        friendlyLabel.snp.makeConstraints{ (make) in
            make.left.right.equalTo(categoryCollectionView).inset(35)
            make.centerX.centerY.equalTo(categoryCollectionView)
        }
    }

    let categoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.collexapp.mainLightWhite
        collectionView.allowsSelection = true
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    let friendlyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FiraSans-Bold", size: 15)
        label.textColor = UIColor.collexapp.mainBlack
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()

}
