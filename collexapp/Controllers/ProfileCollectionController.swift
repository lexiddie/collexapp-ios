//
//  ProfileCollectionController.swift
//  collexapp
//
//  Created by Lex on 20/8/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import ObjectMapper
import Alamofire
import AlamofireImage
import Cache
import SnapKit

class ProfileCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserProfileHeaderDelegate {

    let cellId = "cellId"
    let homePostCellId = "homePostCellId"
    let db = Firestore.firestore()
    var userId: String?
    var user: User!
    
    var isGridView = true
    
    func didChangeToGridView() {
        isGridView = true
        collectionView?.reloadData()
    }
    
    func didChangeToListView() {
        isGridView = false
        collectionView?.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let mainTabBarController = self.tabBarController as! MainTabBarController
        user = mainTabBarController.user
        handleLoadListProduct()
        print("Loading the Collection Controller")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(ProfilerHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionView?.register(ProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(ProductPostCell.self, forCellWithReuseIdentifier: homePostCellId)
        
    }

    
    var listProducts: [ListProduct] = []
        
    
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
                                self.collectionView.reloadData()
                            }
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
                if querySnapshot!.documents.count == 0 {
                    self.listProducts.removeAll()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listProducts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isGridView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfilePhotoCell
            cell.product = listProducts[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homePostCellId, for: indexPath) as! ProductPostCell
            cell.product = listProducts[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isGridView {
            let width = (view.frame.width - 2) / 3
            return CGSize(width: width, height: width)
        } else {
            
            var height: CGFloat = 40 + 8 + 8 //username userprofileimageview
            height += view.frame.width
            height += 50
            height += 60
            
            return CGSize(width: view.frame.width, height: height)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! ProfilerHeaderCell
        
        header.user = self.user
        header.delegate = self
        
        //not correct
        //header.addSubview(UIImageView())
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Clicked \(indexPath)")
    }

}
