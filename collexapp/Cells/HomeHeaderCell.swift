//
//  HomeHeaderCell.swift
//  collexapp
//
//  Created by Lex on 21/8/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit

protocol HomeHeaderDelegate {
    func didChangeToResearch()
}

class HomeHeaderCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var delegate: HomeHeaderDelegate?
    
    var categories = [Category]()
    
    let categoryGridCell = "categoryGridCell"
    
//    var categories: [Category]? {
//        didSet {
//            guard let totalCategories = categories?.count else { return }
//        }
//    }
//
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryCollectionView)
        setupCategoryCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.red
        collectionView.allowsSelection = true
        collectionView.alwaysBounceVertical = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    func setupCategoryCollectionView() {
        categoryCollectionView.snp.makeConstraints { (make) in
            make.top.bottom.centerX.centerY.equalTo(self)
            make.left.right.lessThanOrEqualTo(self)
        }
        categoryCollectionView.register(CategoryGridCell.self, forCellWithReuseIdentifier: categoryGridCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UILabel().text(categories[indexPath.item].name).intrinsicContentSize.width + 25, height: 40.0)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryGridCell, for: indexPath) as! CategoryGridCell
        cell.nameLabel.text = categories[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Click in category collection")
    }
    
//    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
//        categoryCollectionView.delegate = dataSourceDelegate
//        categoryCollectionView.dataSource = dataSourceDelegate
//        categoryCollectionView.tag = row
//        categoryCollectionView.reloadData()
//    }
    
}
