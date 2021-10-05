//
//  ChangeCurrencyController.swift
//  collexapp
//
//  Created by Lex on 22/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import FirebaseFirestore

class ChangeCurrencyController: UIViewController {

    let db = Firestore.firestore().collection("users")
    
    var user: User!
    var currency: Currency!
    var currencyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        setupNavigationItems()
        currencyTextField.text = "\(user.currency.code!) - \(user.currency.name!)"
        currency = user.currency
    }
    
    private func initialView() {
        let view = ChangeCurrencyView(frame: self.view.frame)
        self.view = view
        currencyTextField = view.currencyTextField
    }
    
    @IBAction func handleCurrency(_ sender: Any?) {
        let currencyController = CurrencyController()
        let navigationController = UINavigationController(rootViewController: currencyController)
        navigationController.modalPresentationStyle = .fullScreen
        let viewController = navigationController.topViewController as! CurrencyController
        viewController.previousController = self
        viewController.isChangeCurrency = true
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func handleDismiss(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSave(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
        if user.currency.name != currency.name {
            self.db.document(self.user.id).updateData([
                "currency": currency.toJSON()
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
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
        titleLabel.text = "Currency"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    private func setupLeftNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ArrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(ChangeCurrencyController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
    
    private func setupRightNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ChangeCurrencyController.handleSave(_:)))
    }
}
