//
//  PrivateInformationController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class PrivateInformationController: UIViewController {

    var user: User!
    var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        setupNavigationItems()
        usernameTextField.text = user.email.id
        usernameTextField.isEnabled = false
    }
    
    private func initialView() {
        let view = PrivateInformationView(frame: self.view.frame)
        self.view = view
        usernameTextField = view.googleTextField
    }
    
    @IBAction func handleDismiss(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupNavigationItems() {
        setupTitleNavItem()
        setupLeftNavItem()
    }
    
    private func setupTitleNavItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Private information"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    private func setupLeftNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ArrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(PrivateInformationController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
}
