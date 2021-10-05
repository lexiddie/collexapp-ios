//
//  CreateController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import ObjectMapper
import GoogleMaps
import YPImagePicker
import ImageSlideshow
import AVKit
import SnapKit
import Alamofire
import AlamofireImage

class CreateController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIViewControllerTransitioningDelegate, CLLocationManagerDelegate, UIScrollViewDelegate {

    private var config = YPImagePickerConfiguration()
    
    private let alert = HandleAlert()
    private let defaults = UserDefaults.standard
    private var locationManager = CLLocationManager()
    private var location: CLLocationCoordinate2D!
    let db = Firestore.firestore().collection("products/")
    let storage = Storage.storage()
    var productId = ""
    var user: User!
    var nameLabel: UILabel!
    var universityNameLabel: UILabel!
    var profileImageView: UIImageView!
    var isLocationServicesEnabled = false

    var selectedLocation: CLLocationCoordinate2D!
    var scrollView: UIScrollView!
    var createView: UIView!
    var productImageSlideShow: ImageSlideshow!
    var productPhotos: [UIImage] = []
    var productName: String!
    var productPrice: Double!
    var productCondition: String!
    var productCategory: String!
    var productDescription: String!
    var productNameTextField: UITextField!
    var productPriceTextField: UITextField!
    var productConditionTextField: UITextField!
    var productCategoryTextField: UITextField!
    var productLocationTextField: UITextField!
    var productDescriptionTextView: UITextView!
    
    var activeTextview: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        initialView()
        setupNavigationItems()
        setupLocationManager()
        checkLocationService()
        imagePickerConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handleLocationFormat()
        displayUserInformation(userInfo: user)
    }
    
    private func displayUserInformation(userInfo: User) {
        if userInfo.profileUrl != "" {
            let imageUrl = URL(string: userInfo.profileUrl)
            profileImageView.af.setImage(withURL: imageUrl!)
        } else {
            profileImageView.image = #imageLiteral(resourceName: "ProfileImage").withRenderingMode(.alwaysOriginal)
        }
        nameLabel.text = userInfo.fullName
        universityNameLabel.text = userInfo.university.name
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func handleLocationFormat() {
        if selectedLocation != nil {
            let lat = String(format: "%.2f", selectedLocation.latitude)
            let long = String(format: "%.2f", selectedLocation.longitude)
            productLocationTextField.text = "\(lat), \(long)"
        }
    }
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    private func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("No access Location")
                    isLocationServicesEnabled = false
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access Location")
                    isLocationServicesEnabled = true
                @unknown default:
                break
            }
            } else {
                print("Location services are not enabled")
                isLocationServicesEnabled = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let center = manager.location?.coordinate {
            location = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
        }
    }
    
    private func initialView() {
        let view = CreateView(frame: self.view.frame)
        self.view = view
        self.nameLabel = view.nameLabel
        self.universityNameLabel = view.universityNameLabel
        self.profileImageView = view.profileImageView
        self.createView = view.createView
        self.scrollView = view.scrollView
        self.productImageSlideShow = view.productImageSlideShow
        self.productNameTextField = view.productNameTextField
        self.productPriceTextField = view.productPriceTextField
        self.productConditionTextField = view.productConditionTextField
        self.productCategoryTextField = view.productCategoryTextField
        self.productLocationTextField = view.productLocationTextField
        self.productDescriptionTextView = view.productDescriptionTextView
        productNameTextField.delegate = self
        productPriceTextField.delegate = self
        productConditionTextField.delegate = self
        productCategoryTextField.delegate = self
        productLocationTextField.delegate = self
        productDescriptionTextView.delegate = self
        scrollView.delegate = self
        scrollView.keyboardDismissMode = .onDrag
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        checkLocationService()
        if textField == productLocationTextField {
            if isLocationServicesEnabled {
                handlePickLocation(nil)
                return false
            } else {
                self.alert.showLocationAccess(title: "Location access", alert: "1. Tap Settings\n2. Tap Location\n3. Tap While Using the App", controller: self)
                return false
            }
        } else if textField == productCategoryTextField {
            handlePickCategory(nil)
            return false
        } else if textField == productConditionTextField {
            handlePickCondition(nil)
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.gray {
            textView.text = nil
            textView.textColor = UIColor.collexapp.mainBlack
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Product's description"
            textView.textColor = UIColor.gray
        }
    }
    
    @IBAction func handleViewMessenger(_ sender: Any?) {
        if let url = URL(string: "https://m.me/\(String(user.socialNetworks[0].username))") {
            UIApplication.shared.open(url, options: [:],completionHandler:nil)
        }
    }
    
    @IBAction func handlePickCondition(_ sender: Any?) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let title = NSAttributedString(string: "Select condition", attributes: [NSAttributedString.Key.font: UIFont(name: "FiraSans-Bold", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        alertController.setValue(title, forKey: "attributedMessage")
        alertController.addAction(UIAlertAction(title: "Brand new", style: .default, handler: { (_) in
            self.productCondition = "Brand new"
            self.productConditionTextField.text = "Brand new"
        }))
        alertController.addAction(UIAlertAction(title: "Like new", style: .default, handler: { (_) in
            self.productCondition = "Like new"
            self.productConditionTextField.text = "Like new"
        }))
        alertController.addAction(UIAlertAction(title: "Excellent", style: .default, handler: { (_) in
            self.productCondition = "Excellent"
            self.productConditionTextField.text = "Excellent"
        }))
        alertController.addAction(UIAlertAction(title: "Good", style: .default, handler: { (_) in
            self.productCondition = "Good"
            self.productConditionTextField.text = "Good"
        }))
        alertController.addAction(UIAlertAction(title: "Used", style: .default, handler: { (_) in
            self.productCondition = "Used"
            self.productConditionTextField.text = "Used"
        }))
        alertController.addAction(UIAlertAction(title: "Fair", style: .default, handler: { (_) in
            self.productCondition = "Fair"
            self.productConditionTextField.text = "Fair"
        }))
        alertController.addAction(UIAlertAction(title: "Poor", style: .default, handler: { (_) in
            self.productCondition = "Poor"
            self.productConditionTextField.text = "Poor"
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func handlePickCategory(_ sender: Any?) {
        let categoryController = CategoryController()
        categoryController.previousController = self
        let navigationController = UINavigationController(rootViewController: categoryController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func handlePickLocation(_ sender: Any?) {
        let pickLocationController = PickLocationController()
        pickLocationController.previousController = self
        pickLocationController.location = self.location
        pickLocationController.selectedLocation = self.selectedLocation
        let navigationController = UINavigationController(rootViewController: pickLocationController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func handleDismiss(_ sender: Any?) {
//        locationManager.stopUpdatingLocation()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSave(_ sender: Any?) {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        if (productNameTextField.text?.isEmpty)! || (productPriceTextField.text?.isEmpty)! || (productConditionTextField.text?.isEmpty)! || (productCategoryTextField.text?.isEmpty)! || (productLocationTextField.text?.isEmpty)! || (productDescriptionTextView.text?.isEmpty)! || productPhotos.count == 0 {
            alert.showAlert(title: "Invalid input", alert: "Please fill every information and photo to list the product", controller: self)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            var photoUrls: [String] = []
            let productId = db.document().documentID
            self.productName = self.productNameTextField.text! as String
            self.productPrice = Double(self.productPriceTextField.text!)
            self.productDescription = self.productDescriptionTextView.text! as String
            let product = Product(id: productId, sellerId: self.user.id, university: self.user.university, currency: self.user.currency, name: self.productName.trimmingCharacters(in: .whitespacesAndNewlines), price: self.productPrice, condition: self.productCondition, category: self.productCategory, description: self.productDescription.trimmingCharacters(in: .whitespacesAndNewlines), geoPoint: GeoPoint(lat: self.selectedLocation.latitude, long: self.selectedLocation.longitude), photoUrls: photoUrls)
            self.db.document(productId).setData(product.toJSON()) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
            for i in productPhotos {
                let filename = NSUUID().uuidString
                let uploadData = i.jpegData(compressionQuality: 0.3)
                let storage = Storage.storage().reference().child("product_images").child(filename)
                storage.putData(uploadData!, metadata: nil) { (metadata, err) in
                    if let err = err {
                        print("Failed to upload profile photo \(err)")
                    }
                    storage.downloadURL(completion: { (downloadURL, err) in
                        let currentUrl = (downloadURL?.absoluteString)!
                        photoUrls.append(currentUrl)
                        print("This is my URL \(currentUrl)")
                        if self.productPhotos.count == photoUrls.count {
                            self.db.document(productId).updateData([
                                "photoUrls": photoUrls
                            ]) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Photos successfully written!")
                                    self.locationManager.stopUpdatingLocation()
                                    self.dismiss(animated: true, completion: nil)
                                }
                            }
                        }
                    })
                    print("Successful")
                }
            }
        }
    }
    
    func setupNavigationItems() {
        setupTitleNavItem()
        setupLeftNavItem()
        setupRightNavItem()
    }
    
    private func setupTitleNavItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Create"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    private func setupLeftNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ArrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(CreateController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
    
    private func setupRightNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(CreateController.handleSave(_:)))
    }
    
    private func setupSavingLocation() {
        if location != nil {
            let updateLocation = ["latitude": location.latitude, "longitude": location.longitude]
            defaults.set(updateLocation, forKey: "location")
        }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func handleAddPhotos(_ sender: Any?) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let title = NSAttributedString(string: "Add photos", attributes: [NSAttributedString.Key.font: UIFont(name: "FiraSans-Bold", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        alertController.setValue(title, forKey: "attributedMessage")
        if productPhotos.count != 0 {
            alertController.addAction(UIAlertAction(title: "Remove current photos", style: .destructive, handler: { (_) in
                self.handleRemoveSlideShow()
            }))
        }
        alertController.addAction(UIAlertAction(title: "Choose from library", style: .default, handler: { (_) in
            self.productPhotos.removeAll()
            print("Handle pick product photos")
            let picker = YPImagePicker(configuration: self.config)
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled {
                    print("Picker was canceled")
                }
                for item in items {
                    switch item {
                    case .photo(let photo):
                        print(photo)
                        self.productPhotos.append(photo.image)
                    case .video(let video):
                        print(video)
                    }
                }
                self.handleDisplaySlideShow(isUpdated: !cancelled)
                picker.dismiss(animated: true, completion: nil)
            }
            self.present(picker, animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func handleDisplaySlideShow(isUpdated: Bool) {
        if isUpdated {
            var imageInputs: [ImageSource] = []
            for i in productPhotos {
                imageInputs.append(ImageSource(image: i))
            }
            productImageSlideShow.zoomEnabled = true
            productImageSlideShow.setImageInputs(imageInputs)
        }
    }
    
    private func handleRemoveSlideShow() {
        productPhotos.removeAll()
        productImageSlideShow.zoomEnabled = false
        productImageSlideShow.setImageInputs([ImageSource(image: #imageLiteral(resourceName: "DefaultPhoto").withRenderingMode(.alwaysOriginal))])
    }
    
    private func imagePickerConfig() {
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = true
        config.usesFrontCamera = false
        config.showsPhotoFilters = false
        config.showsVideoTrimmer = false
        config.shouldSaveNewPicturesToAlbum = true
        config.albumName = "collexapp"
//        config.albumName = "DefaultYPImagePickerAlbumName"
        config.startOnScreen = YPPickerScreen.library
        config.screens = [.library]
//        config.screens = [.library, .photo]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = true
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        config.maxCameraZoomFactor = 1.0
        
        config.library.options = nil
        config.library.onlySquare = false
        config.library.isSquareByDefault = true
        config.library.minWidthForItem = nil
        config.library.mediaType = .photo
        config.library.defaultMultipleSelection = true
        config.library.maxNumberOfItems = 5
        config.library.minNumberOfItems = 1
        config.library.numberOfItemsInRow = 3
        config.library.spacingBetweenItems = 1.0
        config.library.skipSelectionsGallery = true
        config.library.preselectedItems = nil
        
        config.video.compression = AVAssetExportPresetHighestQuality
        config.video.fileType = .mov
        config.video.recordingTimeLimit = 60.0
        config.video.libraryTimeLimit = 60.0
        config.video.minimumTimeLimit = 3.0
        config.video.trimmerMaxDuration = 60.0
        config.video.trimmerMinDuration = 3.0
    }
    
}

