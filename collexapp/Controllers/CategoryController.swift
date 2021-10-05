//
//  CategoryController.swift
//  collexapp
//
//  Created by Lex on 23/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper

class CategoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var previousController: UIViewController!
    let categoryCell = "categoryCell"
    var categories = [Category]()
    
    var categoryTableView: UITableView!
    var friendlyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        initialView()
        initialCategoryTableView()
        loadListCategory()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func initialView() {
        let view = CategoryView(frame: self.view.frame)
        self.categoryTableView = view.categoryTableView
        self.friendlyLabel = view.friendlyLabel
        self.view = view
    }
    
    private func initialCategoryTableView() {
        categoryTableView.backgroundColor = UIColor.collexapp.mainLightWhite
        categoryTableView.tableFooterView = UIView()
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(CategoryCell.self, forCellReuseIdentifier: categoryCell)
    }
    
    private func loadListCategory() {
        categories = Mapper<Category>().mapArray(JSONfile: "Category.json")!
        categories = categories.sorted(by: {$0.name < $1.name})
        categoryTableView.reloadData()
    }
    
    @IBAction func handleDismiss(_ sender: Any?) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupNavigationItems() {
        setupTitleNavItem()
        setupLeftNavItem()
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
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
        button.addTarget(self, action: #selector(CategoryController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
}


extension CategoryController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCell, for: indexPath) as! CategoryCell
        cell.nameLabel.text = categories[indexPath.item].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked in a row")
    }
}
