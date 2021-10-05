//
//  MultipleCategoryGridCell.swift
//  collexapp
//
//  Created by Lex on 5/9/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit

protocol MultipleCategoryFlexCellDelegate {
    func didSelect(for cell: MultipleCategoryFlexCell)
}

class MultipleCategoryFlexCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var delegate: MultipleCategoryFlexCellDelegate?
        
    var category: Category? {
        didSet {
            guard let mainCategory = category?.name else { return }
            if mainCategory != "" {
                categoryCollectionView.reloadData()
                mainButton.setTitle(mainCategory, for: .normal)
                selectImageView.image = category?.isSelected == true ? #imageLiteral(resourceName: "SelectedIcon").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "SelectIcon").withRenderingMode(.alwaysOriginal)
                
//                print("checking size 1\(self.categoryCollectionView.collectionViewLayout.collectionViewContentSize)")
//                if let flowLayout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                    flowLayout.estimatedItemSize.height = UICollectionViewFlowLayout.automaticSize.height
//                }
            }
        }
    }
    
    let categoryFlexCell = "categoryFlexCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainButton)
        mainButton.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.left.right.lessThanOrEqualTo(self)
        }
        mainButton.addSubview(selectImageView)
        selectImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(mainButton)
            make.height.width.equalTo(25)
            make.right.lessThanOrEqualTo(mainButton).inset(10)
        }
        mainButton.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(mainButton)
            make.left.right.lessThanOrEqualTo(mainButton)
            make.height.equalTo(0.5)
        }
        addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(40)
            make.bottom.centerX.centerY.equalTo(self)
            make.left.right.lessThanOrEqualTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var mainButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.collexapp.mainLightWhite
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 45)
        button.setTitleColor(UIColor.collexapp.mainBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Bold", size: 17)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        return button
    }()
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        print("checking")
//    }
    
    let selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "SelectIcon").withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.collexapp.mainGrey.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = FlowLayout(minimumInteritemSpacing: 5, minimumLineSpacing: 5)
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.collexapp.mainLightWhite
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryFlexCell.self, forCellWithReuseIdentifier: categoryFlexCell)
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UILabel().text(category?.subcategories[indexPath.item].name ?? "width").intrinsicContentSize.width + 5, height: 40.0)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category?.subcategories.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryFlexCell, for: indexPath) as! CategoryFlexCell
        cell.nameLabel.text = category?.subcategories[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Click in category collection")
    }
    
    @IBAction func handleSelect(_ sender: Any?) {
        delegate?.didSelect(for: self)
    }
}
