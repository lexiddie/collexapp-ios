//
//  HomeController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import ObjectMapper
import Alamofire
import AlamofireImage
import Cache
import SnapKit

let diskConfig = DiskConfig(name: "collexapp")
let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)

let storage = try? Storage(diskConfig: diskConfig,
                           memoryConfig: memoryConfig,
                           transformer: TransformerFactory.forData())

public class FCache {
    public static func set<T: Codable>(_ value: T, key: String, expiry: Expiry? = nil) {
        let typeStorage = storage?.transformCodable(ofType: T.self)
        try? typeStorage?.setObject(value, forKey: key, expiry: expiry)
    }

    public static func get<T: Codable>(_ key: String) -> T? {
        let typeStorage = storage?.transformCodable(ofType: T.self)
        return try? typeStorage?.object(forKey: key)
    }

    public static func isExpired(_ key: String) -> Bool {
        if let b = try? storage?.isExpiredObject(forKey: key) {
            return b
        }
        return true
    }
}

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    private let defaults = UserDefaults.standard
    let db = Firestore.firestore()
    var user: User!
    let productGridCell = "productGridCell"
//    let homeHeaderCell = "homeHeaderCell"
//    let categoryGridCell = "categoryGridCell"
    var listProducts: [ListProduct] = []
    var categories: [Category] = []
    var selectedCategories: [Category] = []
    
    var refreshControl = UIRefreshControl()
    var lastContentOffset: CGFloat = 0
    var friendlyLabel: UILabel!
    var productCollectionView: UICollectionView!
    var categoryCollectionView: UICollectionView!
    var universityButton: UIButton!
    var selectCategoryButton: UIButton!
    
    lazy var homeCategoryView: HomeCategoryView = {
        let view = HomeCategoryView()
        view.homeController = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()   
        loadListCategory()
        initialProductCollectionView()
        setupTitleNavItem()
        updateRealtimeUser()
        loadListProduct()
        print("This is result of currency")
        print(getSymbol(forCurrencyCode: "KHM"))
        
        let subcategory = Subcategory(id: "1dsf7sd98f7", name: "test", isSelected: false).toJSON()
        print(subcategory)
    }
    
    func getSymbol(forCurrencyCode code: String) -> String {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)!
        } else {
            return code
            //return locale.displayName(forKey: .currencySymbol, value: code)
        }
    }
    
//    private func printFonts() {
//        let price = 0 as NSDecimalNumber
//        let availableIdentifiers = Locale.availableIdentifiers
//        var allCurrencySymbols: String = ""
//        for identifier in availableIdentifiers
//        {
//            let locale = Locale(identifier: identifier)
//            let formatter = NumberFormatter()
//            formatter.formatterBehavior = NumberFormatter.Behavior.behavior10_4
//            formatter.numberStyle = NumberFormatter.Style.currency
//            formatter.locale = locale
//            let formattedPrice = formatter.string(from: price)!
//            let currencySymbolsOnly = formattedPrice.replacingOccurrences(of: "0", with: "")
//            print(currencySymbolsOnly)
//            allCurrencySymbols.append(currencySymbolsOnly)
//        }
//
//        var set = Set<Character>()
//        let allCurrencySymbolsMinusDuplicates = String(allCurrencySymbols.filter{ set.insert($0).inserted } )
//        print(allCurrencySymbolsMinusDuplicates)
//    }

    private func initialView() {
        let view = HomeView(frame: self.view.frame)
        self.productCollectionView = view.productCollectionView
        self.friendlyLabel = view.friendlyLabel
        self.universityButton = view.universityButton
        self.view = view
        self.view.addSubview(homeCategoryView)
        self.categoryCollectionView = homeCategoryView.categoryCollectionView
        self.selectCategoryButton = homeCategoryView.selectCategoryButton
        homeCategoryView.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(50)
            make.left.right.lessThanOrEqualTo(self.view)
        }
    }
    
    private func initialProductCollectionView() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ProductGridCell.self, forCellWithReuseIdentifier: productGridCell)
//        mainCollectionView.register(HomeHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: homeHeaderCell)
        refreshControl.addTarget(self, action: #selector(refreshListProduct(_:)), for: UIControl.Event.valueChanged)
        productCollectionView.addSubview(refreshControl)
    }
    
    private func loadFriendlyLabel() {
        if listProducts.count == 0 {
            friendlyLabel.text = "Wow, such empty, please choose another university"
        } else {
            friendlyLabel.text = nil
        }
    }
    
    @IBAction func refreshListProduct(_ sender: Any?) {
        loadListProduct()
        print("Refresh in the home page")
    }

    private func loadListCategory() {
        categories = Mapper<Category>().mapArray(JSONfile: "Categories.json")!
        categories = categories.sorted(by: {$0.name < $1.name})
        homeCategoryView.categories = categories
        categoryCollectionView.reloadData()
    }
    
    private func loadListProduct() {
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
                                self.productCollectionView.reloadData()
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
                    self.productCollectionView.reloadData()
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
        titleLabel.text = "collexapp"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func handleUniversity(_ sender: Any?) {
        let universityController = UniversityController()
        let navigationController = UINavigationController(rootViewController: universityController)
//        navigationController.modalPresentationStyle = .fullScreen
        let viewController = navigationController.topViewController as! UniversityController
        viewController.previousController = self
        viewController.isHome = true
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func handleSelectCategory(_ sender: Any?) {
        let multipleCategoryController = MultipleCategoryController()
        let navigationController = UINavigationController(rootViewController: multipleCategoryController)
        let viewController = navigationController.topViewController as! MultipleCategoryController
        viewController.previousController = self
        self.present(navigationController, animated: true, completion: nil)
    }
}


extension HomeController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productGridCell, for: indexPath) as! ProductGridCell
        cell.productImageView.af.setImage(withURL: URL(string: listProducts[indexPath.item].productImageUrl)!)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let productPriceFormat = numberFormatter.string(from: NSNumber(value: listProducts[indexPath.item].price))
        cell.priceLabel.text = "\(listProducts[indexPath.item].currency!) \(String(productPriceFormat!))"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let checkProductController = CheckProductController()
        print("Checking the product ID in list \(String(listProducts[indexPath.item].id))")
        checkProductController.productId = listProducts[indexPath.item].id
        checkProductController.user = user
        let navigationController = UINavigationController(rootViewController: checkProductController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("yet 2")
//    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: homeHeaderCell, for: indexPath) as! HomeHeaderCell
//        header.categories = self.categories
//        header.delegate = self
//        return header
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 50)
//    }
}
