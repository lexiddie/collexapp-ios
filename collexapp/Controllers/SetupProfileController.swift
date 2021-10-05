//
//  SetupProfileController.swift
//  collexapp
//
//  Created by Lex on 19/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import CryptoSwift
import ObjectMapper

class SetupProfileController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let alert = HandleAlert()
    private let dateTime = HandleDateTime()
    private let defaults = UserDefaults.standard
    let db = Firestore.firestore().collection("users")
    
    var profileUrl: String = ""
    var socialNetworks: [SocialNetwork] = []
    var user: User!
    var university: University!
    var currency: Currency!
    
    var profileImageView: UIImageView!
    var uploadProfileButton: UIButton!
    var universityTextField: UITextField!
    var currencyTextField: UITextField!
    var messengerTextField: UITextField!
    var signUpButton: UIButton!
    var profileImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        initialView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func initialView() {
        let view = SetupProfileView(frame: self.view.frame)
        self.view = view
        profileImageView = view.profileImageView
        uploadProfileButton = view.uploadProfileButton
        universityTextField = view.universityTextField
        currencyTextField = view.currencyTextField
        messengerTextField = view.messengerTextField
        signUpButton = view.signUpButton
        universityTextField.delegate = self
        currencyTextField.delegate = self
        messengerTextField.delegate = self
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

    @IBAction func handleUploadProfile(_ sender: Any?) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let title = NSAttributedString(string: "Upload profile photo", attributes: [NSAttributedString.Key.font: UIFont(name: "FiraSans-Bold", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        alertController.setValue(title, forKey: "attributedMessage")
        if profileImage != nil {
            alertController.addAction(UIAlertAction(title: "Remove current photo", style: .destructive, handler: { (_) in
                self.profileImage = nil
                self.profileImageView.image = #imageLiteral(resourceName: "ProfileImage").withRenderingMode(.alwaysOriginal)
            }))
        }
//        alertController.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { (_) in
//
//        }))
        alertController.addAction(UIAlertAction(title: "Choose from library", style: .default, handler: { (_) in
            let imagePickerController = UIImagePickerController()
            UIImagePickerController.availableMediaTypes(for: .photoLibrary)
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.mediaTypes = ["public.image"]
//            imagePickerController.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            profileImage = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            profileImage = originalImage
        }
        profileImageView.image = profileImage
        dismiss(animated: true, completion: nil)
    }

    @IBAction func handleUniversity(_ sender: Any?) {
        let universityController = UniversityController()
        let navigationController = UINavigationController(rootViewController: universityController)
        navigationController.modalPresentationStyle = .fullScreen
        let viewController = navigationController.topViewController as! UniversityController
        viewController.previousController = self
        viewController.isSetupProfile = true
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func handleCurrency(_ sender: Any?) {
        let currencyController = CurrencyController()
        let navigationController = UINavigationController(rootViewController: currencyController)
        navigationController.modalPresentationStyle = .fullScreen
        let viewController = navigationController.topViewController as! CurrencyController
        viewController.previousController = self
        viewController.isSetupProfile = true
        self.present(navigationController, animated: true, completion: nil)
    }

    @IBAction func handleSignUp(_ sender: Any?) {
        signUpButton.isEnabled = false
        if (universityTextField.text?.isEmpty)! || (currencyTextField.text?.isEmpty)! || (messengerTextField.text?.isEmpty)! {
            alert.showAlert(title: "Invalid Selection", alert: "Please select University, Currency, and fil Messenger ID to sign up", controller: self)
            signUpButton.isEnabled = true
        } else {
            let signUp = {
                let messengerID = self.messengerTextField.text! as String
                let messenger = SocialNetwork(name: "Messenger", username: messengerID.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
                self.socialNetworks.append(messenger)
                self.user.socialNetworks = self.socialNetworks
                self.user.university = self.university
                self.user.currency = self.currency
                self.user.createdDateTime = self.dateTime.getDateTime()
                self.user.id = self.db.document().documentID
                self.db.document(self.user.id).setData(self.user.toJSON()) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                let initiateUser = ["login": true, "id": self.user.id!] as [String: Any]
                self.defaults.set(initiateUser, forKey: "user")
                let mainTabBarController = MainTabBarController()
                mainTabBarController.user = self.user
                mainTabBarController.modalPresentationStyle = .fullScreen
//                let navController = mainTabBarController.viewControllers!.first as! UINavigationController
//                let viewController = navController.topViewController as! HomeController
//                viewController.user = self.user
                self.present(mainTabBarController, animated: true, completion: nil)
            }

            if profileImage != nil {
                let filename = NSUUID().uuidString
                let uploadData = profileImage.jpegData(compressionQuality: 0.3)
                let storage = Storage.storage().reference().child("profile_images").child(filename)
                storage.putData(uploadData!, metadata: nil) { (metadata, err) in
                    if let err = err {
                        print("Failed to upload profile photo \(err)")
                    }
                    storage.downloadURL(completion: { (downloadURL, err) in
                        self.profileUrl = (downloadURL?.absoluteString)!
                        self.user.profileUrl = self.profileUrl
                        print("This is my URL \(self.profileUrl)")
                        signUp()
                    })
                    print("Successful")
                }
            } else {
                signUp()
            }
        }
    }
}
