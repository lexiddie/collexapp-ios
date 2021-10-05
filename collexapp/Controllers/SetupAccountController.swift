//
//  SetupAccountController.swift
//  collexapp
//
//  Created by Lex on 19/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import CryptoSwift
import GoogleSignIn

class SetupAccountController: UIViewController, UITextFieldDelegate {
    
    private let alert = HandleAlert()
    var userGoogle: GIDGoogleUser!
    var user: User!
    let db = Firestore.firestore().collection("users")
    
    var nameLabel: UILabel!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var confirmpasswordTextField: UITextField!
    var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        nameLabel.text = "Welcome \(userGoogle.profile.givenName!)"
    }
    
    private func initialView() {
        let view = SetupAccountView(frame: self.view.frame)
        self.view = view
        self.nameLabel = view.nameLabel
        self.usernameTextField = view.usernameTextField
        self.passwordTextField = view.passwordTextField
        self.confirmpasswordTextField = view.confirmPasswordTextField
        self.nextButton = view.nextButton
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        confirmpasswordTextField.delegate = self
    }
    
    @IBAction func handleNext(_ sender: Any?) {
        nextButton.isEnabled = false
        if (usernameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (confirmpasswordTextField.text?.isEmpty)! {
            alert.showAlert(title: "Invalid Input", alert: "Please fill the informations to proceed", controller: self)
            nextButton.isEnabled = true
        } else {
            if passwordTextField.text! != confirmpasswordTextField.text! {
                alert.showAlert(title: "Warning", alert: "Your password does not match", controller: self)
                nextButton.isEnabled = true
            } else {
                let provider = Provider(name: "Google", email: userGoogle.profile.email)
                let email = Email(id: userGoogle.profile.email, verified: true)
                let username = self.usernameTextField.text! as String
                let password = self.passwordTextField.text! as String
                let hashPassword = password.sha256()
                
                db
                    .whereField("username", isEqualTo: username.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
                    .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if querySnapshot!.documents.count == 0 {
                            self.user = User(fullName: self.userGoogle.profile.name, username: username.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(), password: hashPassword, provider: provider, email: email)
                            let setupProfileController = SetupProfileController()
                            setupProfileController.user = self.user
                            self.navigationController?.pushViewController(setupProfileController, animated: true)
                        } else {
                            self.alert.showAlert(title: "Invalid input", alert: "This username is already taken!", controller: self)
                            self.nextButton.isEnabled = true
                        }
                    }
                }
            }
        }
    }
}
