//
//  ProfileController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import Alamofire
import AlamofireImage
import ObjectMapper
   

class EditProfileController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let alert = HandleAlert()
    let db = Firestore.firestore().collection("users")
    let storage = Storage.storage()
    
    var profileUrl: String = ""
    var user: User!
    var fullName: String!
    var username: String!
    var messengerUsername: String!
    var profileImageView: UIImageView!
    var uploadProfileButton: UIButton!
    var profileImage: UIImage!
    var nameTextField: UITextField!
    var usernameTextField: UITextField!
    var messengerTextField: UITextField!
    var activeTextField : UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        initialView()
        setupNavigationItems()
        fullName = user.fullName
        username = user.username
        messengerUsername = user.socialNetworks[0].username
        nameTextField.text = fullName
        usernameTextField.text = username
        messengerTextField.text = messengerUsername
    }
    
    override func viewDidAppear(_ animated: Bool) {
        displayUserProfile()
    }
    
    private func displayUserProfile() {
        if user.profileUrl != "" {
            let imageUrl = URL(string: user.profileUrl)
            profileImageView.af.setImage(withURL: imageUrl!)
            profileImage = profileImageView.image
        }
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
    
    private func initialView() {
        let view = EditProfileView(frame: self.view.frame)
        self.view = view
        self.profileImageView = view.profileImageView
        self.nameTextField = view.nameTextField
        self.usernameTextField = view.usernameTextField
        self.messengerTextField = view.messengerTextField
        nameTextField.delegate = self
        usernameTextField.delegate = self
        messengerTextField.delegate = self
    }
    
    
    @IBAction func handleUploadProfile(_ sender: Any?) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let title = NSAttributedString(string: "Upload profile photo", attributes: [NSAttributedString.Key.font: UIFont(name: "FiraSans-Bold", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        alertController.setValue(title, forKey: "attributedMessage")
        if profileImage != nil {
            alertController.addAction(UIAlertAction(title: "Remove current photo", style: .destructive, handler: { (_) in
                self.profileImage = nil
                self.profileImageView.image = #imageLiteral(resourceName: "ProfileImage").withRenderingMode(.alwaysOriginal)
                self.handleDeleteProfile()
            }))
        }
        alertController.addAction(UIAlertAction(title: "Choose from library", style: .default, handler: { (_) in
            let imagePickerController = UIImagePickerController()
            UIImagePickerController.availableMediaTypes(for: .photoLibrary)
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.mediaTypes = ["public.image"]
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
        handleDeleteProfile()
        handleUpdateProfile()
        dismiss(animated: true, completion: nil)
    }
    
    private func handleDeleteProfile() {
        storage.reference(forURL: user.profileUrl).delete { error in
            if let error = error {
                print(error)
            } else {
                print("Delete ProfilePhoto Successful")
                self.db.document(self.user.id).updateData([
                    "profileUrl": ""
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
    
    private func handleUpdateProfile() {
        if profileImage != nil {
            let filename = NSUUID().uuidString
            let uploadData = profileImage.jpegData(compressionQuality: 0.3)
            let storagePhotoName = storage.reference().child("profile_images").child(filename)
            storagePhotoName.putData(uploadData!, metadata: nil) { (metadata, err) in
                if let err = err {
                    print("Failed to upload profile photo \(err)")
                }
                storagePhotoName.downloadURL(completion: { (downloadURL, err) in
                    self.profileUrl = (downloadURL?.absoluteString)!
                    print("This is my URL \(self.profileUrl)")
                    self.db.document(self.user.id).updateData([
                        "profileUrl": self.profileUrl
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                })
                print("Successful")
            }
        }
    }
    
    @IBAction func handleDismiss(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSave(_ sender: Any?) {
        fullName = self.nameTextField.text! as String
        username = self.usernameTextField.text! as String
        messengerUsername = self.messengerTextField.text! as String
        if (nameTextField.text?.isEmpty)! || (usernameTextField.text?.isEmpty)! || (messengerTextField.text?.isEmpty)! {
            alert.showAlert(title: "Invalid Input", alert: "The informations must not be empty!", controller: self)
        } else {
            db
                .whereField("username", isEqualTo: self.username.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
                .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if querySnapshot!.documents.count == 0 {
                        print("No value")
                        self.dismiss(animated: true, completion: nil)
                        if self.user.fullName != self.fullName || self.user.username != self.username.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() || self.user.socialNetworks[0].username != self.messengerUsername {
                            self.handleUpdateInformation()
                        }
                    } else if querySnapshot!.documents.count > 0 && self.user.username == self.username.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(){
                        self.dismiss(animated: true, completion: nil)
                        if self.user.fullName != self.fullName || self.user.socialNetworks[0].username != self.messengerUsername {
                            self.handleUpdateInformation()
                        }
                    } else {
                        self.alert.showAlert(title: "Invalid input", alert: "This username has been taken, please try another.", controller: self)
                    }
                }
            }
        }
    }
    
    func handleUpdateInformation() {
        self.db.document(self.user.id).updateData([
            "fullName": self.fullName!,
            "username": self.username.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(),
            "socialNetworks": [SocialNetwork(username: self.messengerUsername.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()).toJSON()]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
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
        titleLabel.text = "Profile"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    private func setupLeftNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ArrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(EditProfileController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
    
    private func setupRightNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(EditProfileController.handleSave(_:)))
    }
}
