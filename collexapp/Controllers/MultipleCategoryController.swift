//
//  MultipleCategoryController.swift
//  collexapp
//
//  Created by Lex on 5/9/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper

class MultipleCategoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MultipleCategoryFlexCellDelegate {

    var previousController: UIViewController!
    let multipleCategoryFlexCell = "multipleCategoryFlexCell"
    var categories = [Category]()
    var selectedCategories: [Category] = []
    var sortedCategories: [Category] = []
    
    var categoryCollectionView: UICollectionView!
    var friendlyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        initialView()
        initialCategoryCollectionView()
        loadListCategory()
    }
    
    private func initialView() {
        let view = MultipleCategoryView(frame: self.view.frame)
        self.categoryCollectionView = view.categoryCollectionView
        self.friendlyLabel = view.friendlyLabel
        self.view = view
    }
    
    private func initialCategoryCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(MultipleCategoryFlexCell.self, forCellWithReuseIdentifier: multipleCategoryFlexCell)
    }
    
    private func loadListCategory() {
        categories = Mapper<Category>().mapArray(JSONfile: "Category.json")!
        categories = categories.sorted(by: {$0.name < $1.name})
        categoryCollectionView.reloadData()
    }
    
    func didSelect(for cell: MultipleCategoryFlexCell) {
        print("did selecting")
        guard let indexPath = categoryCollectionView?.indexPath(for: cell) else { return }
        let category = categories[indexPath.item]
        category.isSelected = !category.isSelected
        self.categories[indexPath.item] = category
        self.categoryCollectionView?.reloadItems(at: [indexPath])
    }
       
    @IBAction func handleDismiss(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleCategory(_ sender: Any?) {
        let viewController = CategoryController()
        viewController.navigationItem.title = "Category"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupNavigationItems() {
        setupTitleNavItem()
        setupLeftNavItem()
        setupRightNavItem()
    }
    
    private func setupTitleNavItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Category"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    private func setupLeftNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ArrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(MultipleCategoryController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
    
    private func setupRightNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "CategoryIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(MultipleCategoryController.handleCategory(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
}

extension MultipleCategoryController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = estimateCollectionViewHeight(subcategories: categories[indexPath.item].subcategories)
//        print("Checking individual height \(height)")
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleCategoryFlexCell, for: indexPath) as! MultipleCategoryFlexCell
        cell.category = categories[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select on the specific row")
    }
    
    func estimateCollectionViewHeight(subcategories: [Subcategory]) -> CGFloat {
        if subcategories.count == 0 { return 40.0 }
        var totalWidth: CGFloat = 0.0
        let label = UILabel()
        for i in subcategories {
            totalWidth += (label.text(i.name).intrinsicContentSize.width + 5)
        }
        print("Check total width \(totalWidth) & check screen width \(view.frame.width)")
        let valueRatio = Int(totalWidth / (view.frame.width - 10))
        return CGFloat((valueRatio * 5) + ((valueRatio + 1) * 40)) + 50
    }
    
//    private func sortCategories(subcategories: [Subcategory]) {
//
//        var screenWidth = view.frame.width
//        var tempCategories = [Subcategory]()
//
//        while subcategories.count != 0 {
//            var tempMax = [Subcategory]()
//            for i in subcategories {
//
//            }
//        }
//    }
//
//    private func getTotalWidth(subcategories: [Subcategory]) -> CGFloat {
//        var totalWidth: CGFloat = 0.0
//        let label = UILabel()
//        for i in subcategories {
//            totalWidth += (label.text(i.name).intrinsicContentSize.width + 5)
//        }
//        return totalWidth
//    }
    
}
