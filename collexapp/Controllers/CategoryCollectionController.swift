//
//  CategoryCollectionController.swift
//  collexapp
//
//  Created by Lex on 19/8/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper

class CategoryCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let categoryGridCell = "categoryGridCell"
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = Mapper<Category>().mapArray(JSONfile: "Categories.json")!
        categories = categories.sorted(by: {$0.name < $1.name})
        setupCollectionView()
    }

    private func setupCollectionView() {
        self.view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CategoryGridCell.self, forCellWithReuseIdentifier: categoryGridCell)
//        self.view.addSubview(collectionView)
//        collectionView.snp.makeConstraints { (make) in
//            make.top.left.right.bottom.equalTo(self.view)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.estimatedFrame(text: categories[indexPath.item].name).width
        return CGSize(width: width, height: 25.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryGridCell, for: indexPath) as! CategoryGridCell
        cell.nameLabel.text = categories[indexPath.item].name
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Click in category collection")
    }
    
    func estimatedFrame(text: String) -> CGRect {
        //Temporary Size
        let size = CGSize(width: 100, height: 25)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, context: nil)
    }
}
