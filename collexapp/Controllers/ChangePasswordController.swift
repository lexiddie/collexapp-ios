//
//  ChangePasswordController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import ObjectMapper
import CryptoSwift

class ChangePasswordController: UIViewController {

    private let alert = HandleAlert()
    let db = Firestore.firestore().collection("users")
    var user: User!
    
    
    var currentPasswordTextField: UITextField!
    var newPasswordTextField: UITextField!
    var verifyPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        setupNavigationItems()
    }
    
    private func initialView() {
        let view = ChangePasswordView(frame: self.view.frame)
        self.view = view
        currentPasswordTextField = view.currentPasswordTextField
        newPasswordTextField = view.newPasswordTextField
        verifyPasswordTextField = view.verifyPasswordTextField
    }
    
    @IBAction func handleSave(_ sender: Any?) {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        if (currentPasswordTextField.text?.isEmpty)! || (newPasswordTextField.text?.isEmpty)! || (verifyPasswordTextField.text?.isEmpty)! {
            self.alert.showAlert(title: "Invalid Input", alert: "The fields must not be empty", controller: self)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            let currentPassword = self.currentPasswordTextField.text! as String
            let newPassword = self.newPasswordTextField.text! as String
            let verifyPassword = self.verifyPasswordTextField.text! as String
            if newPassword != verifyPassword {
                self.alert.showAlert(title: "Warning", alert: "Your password does not match", controller: self)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            } else if currentPassword.sha256() != user.password {
                self.alert.showAlert(title: "Warning", alert: "Your current password is incorrect", controller: self)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                self.db.document(self.user.id).updateData([
                    "password": newPassword.sha256(),
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }

    }
    
    @IBAction func handleDismiss(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupNavigationItems() {
        setupTitleNavItem()
        setupLeftNavItem()
        setupRightNavItem()
    }
    
    private func setupTitleNavItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Change password"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    private func setupLeftNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ArrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(ChangePasswordController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
    
    private func setupRightNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ChangePasswordController.handleSave(_:)))
    }
}
