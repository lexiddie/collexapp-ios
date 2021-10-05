//
//  CheckProductController.swift
//  collexapp
//
//  Created by Lex on 24/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import ObjectMapper
import Alamofire
import AlamofireImage
import Cache
import SnapKit
import GoogleMaps
import ImageSlideshow

class CheckProductController: UIViewController, UITextViewDelegate {

    private let alert = HandleAlert()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    var user: User!
    var sellerMessengerUrl: String = ""
    var productId: String!
    var product: Product!
    var isSaved: Bool = false
    var isOwner: Bool = false
    var googleMapView: GMSMapView!
    
    var productImageSlideShow: ImageSlideshow!
    var productNameLabel: UILabel!
    var productPriceLabel: UILabel!
    var productConditionLabel: UILabel!
    var productCategoryLabel: UILabel!
    var sellerProfileImageView: UIImageView!
    var sellerNameLabel: UILabel!
    var sellerUniversityNameLabel: UILabel!
    var viewMessengerButton: UIButton!
    var optionButton: UIButton!
    var soldButton: UIButton!
    var productDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        setupNavigationItems()
        hanldeFetchData()
    }
    
    private func initialView() {
        let view = CheckProductView(frame: self.view.frame)
        self.view = view
        productImageSlideShow = view.productImageSlideShow
        productNameLabel = view.productNameLabel
        productPriceLabel = view.productPriceLabel
        productConditionLabel = view.productConditionLabel
        productCategoryLabel = view.productCategoryLabel
        sellerProfileImageView = view.profileImageView
        sellerNameLabel = view.nameLabel
        sellerUniversityNameLabel = view.universityNameLabel
        viewMessengerButton = view.viewMessengerButton
        optionButton = view.optionButton
        soldButton = view.soldButton
        productDescriptionTextView = view.productDescriptionTextView
        productDescriptionTextView.delegate = self
        googleMapView = view.googleMapView
        optionButton.isHidden = true
        soldButton.isHidden = true
    }
    
    private func hanldeFetchData() {
        self.db.collection("products").document(productId).getDocument { (document, error) in
            if let document = document, document.exists {
                self.product = Mapper<Product>().map(JSONObject: document.data())!
                self.handleFillInformation()
            } else {
                print("Document does not exist")
            }
        }
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    @IBAction func handleViewMessenger(_ sender: Any?) {
        if let url = URL(string: "https://m.me/\(String(sellerMessengerUrl))") {
            UIApplication.shared.open(url, options: [:],completionHandler:nil)
        }
    }
    
    private func handleFillInformation() {
        let downloader = ImageDownloader()
        var imageInputs: [ImageSource] = []
        for i in product.photoUrls {
            let urlRequest = URLRequest(url: URL(string: i)!)
            downloader.download(urlRequest) { response in
                if case .success(let image) = response.result {
                    imageInputs.append(ImageSource(image: image))
                    if self.product.photoUrls.count == imageInputs.count {
                        self.productImageSlideShow.zoomEnabled = true
                        self.productImageSlideShow.setImageInputs(imageInputs)
                    }
                }
            }
        }
        
        if user.id == product.sellerId {
            isOwner = true
            soldButton.isHidden = false
            optionButton.isHidden = false
            optionButton.setImage(#imageLiteral(resourceName: "DeleteLogo").withRenderingMode(.alwaysOriginal), for: .normal)
            if product.isSold {
                soldButton.isHidden = false
                soldButton.isEnabled = false
                soldButton.setImage(#imageLiteral(resourceName: "SoldRedIcon").withRenderingMode(.alwaysOriginal), for: .normal)
            }
        } else {
            optionButton.isHidden = false
            optionButton.setImage(#imageLiteral(resourceName: "SoldIcon").withRenderingMode(.alwaysOriginal), for: .normal)
            if product.isSold {
                soldButton.isHidden = false
                soldButton.isEnabled = false
                soldButton.setImage(#imageLiteral(resourceName: "SoldRedIcon").withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }

        productNameLabel.text = product.name
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let productPriceFormat = numberFormatter.string(from: NSNumber(value: product.price))
        productPriceLabel.text = "Price: \(String(product.currency.code!)) \(String(productPriceFormat!))"
        productConditionLabel.text = "Product condition: \(String(product.condition))"
        productCategoryLabel.text = "Product category: \(String(product.category))"
        self.db.collection("users").document( product.sellerId).getDocument { (document, error) in
            if let document = document, document.exists {
                let user = Mapper<User>().map(JSONObject: document.data())!
                self.sellerNameLabel.text = user.fullName
                self.sellerMessengerUrl = user.socialNetworks[0].username
                if user.profileUrl != "" {
                    self.sellerProfileImageView.af.setImage(withURL: URL(string: user.profileUrl)!)
                }
            } else {
                print("Document does not exist")
            }
        }
        sellerUniversityNameLabel.text = product.university.name
        productDescriptionTextView.text = product.description
        updateMapCamera()
        handleCheckIsSaved()
    }
    
    func deleteProduct() {
        for i in product.photoUrls {
            self.storage.reference(forURL: i).delete { error in
                if let error = error {
                    print(error)
                } else {
                    print("Delete photo Successful \(String(i))")
                }
            }
        }
        self.db.collection("products").document(productId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func soldProduct() {
        self.db.collection("products").document(productId).updateData([
            "isSold": true
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                self.soldButton.isEnabled = false
                self.soldButton.setImage(#imageLiteral(resourceName: "SoldRedLogo").withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
    
    func saveProduct() {
        if !isOwner {
            optionButton.isEnabled = false
            let saveDb = db.collection("saves")
            let savedProductId = saveDb.document().documentID
            let saveProduct = SaveProduct(id: savedProductId, productId: productId, userId: user.id)
            self.db.collection("saves").document(savedProductId).setData(saveProduct.toJSON()) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.optionButton.setImage(#imageLiteral(resourceName: "SaveSelected").withRenderingMode(.alwaysOriginal), for: .normal)
                    self.optionButton.isEnabled = true
                    self.isSaved = true
                }
            }
        }
    }
    
    func unsavedProduct() {
        optionButton.isEnabled = false
        db.collection("saves")
            .whereField("productId", isEqualTo: productId!)
            .whereField("userId", isEqualTo: user.id!)
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID)")
                    self.db.collection("saves").document(document.documentID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                            self.optionButton.setImage(#imageLiteral(resourceName: "SaveUnselected").withRenderingMode(.alwaysOriginal), for: .normal)
                            self.optionButton.isEnabled = true
                            self.isSaved = false
                        }
                    }
                }
            }
        }
    }
    
    
    func handleCheckIsSaved() {
        if !isOwner {
            db.collection("saves")
                .whereField("productId", isEqualTo: productId!)
                .whereField("userId", isEqualTo: user.id!)
                .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID)")
                        self.isSaved = true
                        self.optionButton.setImage(#imageLiteral(resourceName: "SaveSelected").withRenderingMode(.alwaysOriginal), for: .normal)
                        self.optionButton.isEnabled = true
                    }
                }
            }
        }
    }
    
    private func updateMapCamera() {
        if product.geoPoint != nil {
            CATransaction.begin()
            CATransaction.setValue(0.5, forKey: kCATransactionAnimationDuration)
            googleMapView.animate(with: GMSCameraUpdate.setTarget(CLLocationCoordinate2D(latitude: product.geoPoint.lat, longitude: product.geoPoint.long)))
            googleMapView.animate(toZoom: 14)
            googleMapView.isUserInteractionEnabled = false
            CATransaction.commit()
        }

    }
    
    @IBAction func handleDismiss(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleOption(_ sender: Any?) {
        if isOwner {
            self.alert.showAlertDeleteProduct(title: "Delete confirmation", alert: "Do you want to delete this product?", controller: self)
        } else if isSaved {
            self.alert.showAlertUnsaveProduct(title: "Unsave confirmation", alert: "Do you want to unsave this product?", controller: self)
        } else if !isSaved {
            self.alert.showAlertSaveProduct(title: "Save confirmation", alert: "Do you want to save this product?", controller: self)
        }
    }
    
    @IBAction func handleSold(_ sender: Any?) {
        if isOwner {
            self.alert.showAlertSoldProduct(title: "Sold confirmation", alert: "Do you want to sold this product?", controller: self)
        }
    }
    
    func setupNavigationItems() {
        setupTitleNavItem()
        setupLeftNavItem()
    }
    
    private func setupTitleNavItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Product"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    private func setupLeftNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ArrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(CheckProductController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
}
