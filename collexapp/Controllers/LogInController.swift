//
//  LogInController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import ObjectMapper
import CryptoSwift

class LogInController: UIViewController, UITextFieldDelegate {

    private let alert = HandleAlert()
    private let defaults = UserDefaults.standard
    let db = Firestore.firestore().collection("users")
    var user: User!
    
    var previousController: UIViewController!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var username:String!
    var password:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func initialView() {
        let view = LogInView(frame: self.view.frame)
        self.view = view
        self.usernameTextField = view.usernameTextField
        self.passwordTextField = view.passwordTextField
    }
    
    @IBAction func handleLogo(_ sender: Any?) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func handleLogIn(_ sender: Any?) {
        if (usernameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            self.alert.showAlert(title: "Invalid Input", alert: "The Username or Password is empty", controller: self)
        } else {
            self.username = self.usernameTextField.text! as String
            self.password = self.passwordTextField.text! as String
            
            db
                .whereField("username", isEqualTo: self.username.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
                .whereField("password", isEqualTo: self.password.sha256())
                .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID)")
                        self.user = Mapper<User>().map(JSONObject: document.data())!
                        let userJson = Mapper().toJSONString(self.user, prettyPrint: true)!
                        print("Current data: \(userJson)")
                        let initiateUser = ["login": true, "id": self.user.id!] as [String: Any]
                        self.defaults.set(initiateUser, forKey: "user")
                        let mainTabBarController = MainTabBarController()
                        mainTabBarController.user = self.user
                        mainTabBarController.modalPresentationStyle = .fullScreen
                        self.present(mainTabBarController, animated: true, completion: nil)
                        return
                    }
                    if querySnapshot!.documents.count == 0 {
                        print("No value")
                        self.alert.showAlert(title: "Invalid input", alert: "Incorrect Username or Password", controller: self)
                    }
                }
            }
        }
        
    }
    
    @IBAction func handleSignUp(_ sender: Any?) {
        guard let mainControllers: [UIViewController] = self.navigationController?.viewControllers else { return }
        if previousController == mainControllers[0] {
            let signUpController = SignUpController()
            signUpController.previousController = self
            navigationController?.pushViewController(signUpController, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
