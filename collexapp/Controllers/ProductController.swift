//
//  ProductController.swift
//  collexapp
//
//  Created by Lex on 19/8/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import ObjectMapper
import Alamofire
import AlamofireImage
import Cache
import SnapKit

class ProductController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let defaults = UserDefaults.standard
    let db = Firestore.firestore()
    var user: User!
    let productCell = "productCell"
    var listProducts: [ListProduct] = []
    var refreshControl = UIRefreshControl()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.white
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.allowsSelection = true
        return table
    }()
    
    let friendlyLabel: UILabel = {
        let label = UILabel()
        label.text = "Wow, such empty, please choose another university"
        label.font = UIFont(name: "FiraSans-Bold", size: 15)
        label.textColor = UIColor.collexapp.mainBlack
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        setupTableView()
        setupTitleNavItem()
        updateRealtimeUser()
        handleLoadListProduct()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handleLoadListProduct()
    }

    private func initialView() {
        let view = HomeView(frame: self.view.frame)
        self.view = view
    }
    
    private func setupTableView() {
        self.view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: productCell)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
        tableView.addSubview(friendlyLabel)
        friendlyLabel.snp.makeConstraints{ (make) in
            make.left.right.equalTo(tableView).inset(35)
            make.centerX.centerY.equalTo(tableView)
        }
        refreshControl.addTarget(self, action: #selector(refreshListProduct(_:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func loadFriendlyLabel() {
        if listProducts.count == 0 {
            friendlyLabel.text = "Wow, such empty, please choose another university"
        } else {
            friendlyLabel.text = nil
        }
    }
    
    @IBAction func refreshListProduct(_ sender: Any?) {
        handleLoadListProduct()
    }
    
    private func handleLoadListProduct() {
        print("Fetching data")
        db.collection("products")
            .whereField("isSold", isEqualTo: false)
            .whereField("university.name", in: [user.university.name!])
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var tempProducts: [ListProduct] = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID)")
                    let currentProduct = Mapper<Product>().map(JSONObject: document.data())!
                    self.db.collection("users").document(currentProduct.sellerId).getDocument { (document, error) in
                        if let document = document, document.exists {
                            let currentUser = Mapper<User>().map(JSONObject: document.data())!
                            let listProduct = ListProduct(id: currentProduct.id, productImageUrl: currentProduct.photoUrls[0], sellerId: currentProduct.sellerId, sellerImageUrl: currentUser.profileUrl, name: currentProduct.name, price: currentProduct.price, currency: currentProduct.currency.code, condition: currentProduct.condition, category: currentProduct.category, location: currentProduct.geoPoint)
                            tempProducts.append(listProduct)
                            if querySnapshot!.documents.count == tempProducts.count {
                                self.listProducts.removeAll()
                                self.listProducts = tempProducts
                                self.refreshControl.endRefreshing()
                                self.tableView.reloadData()
                                self.loadFriendlyLabel()
                            }
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
                if querySnapshot!.documents.count == 0 {
                    self.listProducts.removeAll()
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                    self.loadFriendlyLabel()
                }
            }
        }
    }
    
    private func updateRealtimeUser() {
        let mainTabBarController = self.tabBarController as! MainTabBarController
        user = mainTabBarController.user
        let user = defaults.object(forKey: "user")
        if let check = user as? [String: Any] {
            db.collection("users").document(check["id"] as! String).addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                self.user = Mapper<User>().map(JSONObject: data)!
                FCache.set(self.user, key: "userInfo")
                print("Add user into Cach")
                let userJson = Mapper().toJSONString(self.user, prettyPrint: true)!
                print("Current data: \(userJson)")
                mainTabBarController.user = self.user
            }
        
        }
    }
    
    private func setupTitleNavItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: productCell, for: indexPath) as! ProductCell
        print("Checking the productImageUrl in list \(String(listProducts[indexPath.item].productImageUrl))")
        cell.productImageView.af.setImage(withURL: URL(string: listProducts[indexPath.item].productImageUrl)!)
        if listProducts[indexPath.item].sellerImageUrl != "" {
            print("Checking the sellerImageUrl in list \(String(listProducts[indexPath.item].sellerImageUrl))")
            cell.sellerProfileImageView.af.setImage(withURL: URL(string: listProducts[indexPath.item].sellerImageUrl)!)
        }
        cell.productNameLabel.text = listProducts[indexPath.item].name
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let productPriceFormat = numberFormatter.string(from: NSNumber(value: listProducts[indexPath.item].price))
        cell.productPriceLabel.text = "\(listProducts[indexPath.item].currency!) \(String(productPriceFormat!))"
        cell.selectionStyle = UITableViewCell.SelectionStyle.gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checkProductController = CheckProductController()
        print("Checking the product ID in list \(String(listProducts[indexPath.item].id))")
        checkProductController.productId = listProducts[indexPath.item].id
        checkProductController.user = user
        let navigationController = UINavigationController(rootViewController: checkProductController)
//        navigationController.modalPresentationStyle = .fullScreen
        tableView.deselectRow(at: indexPath, animated: true)
        self.present(navigationController, animated: true, completion: nil)
    }

}
