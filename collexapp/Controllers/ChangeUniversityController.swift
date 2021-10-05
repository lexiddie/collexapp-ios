//
//  ChangeUniversityController.swift
//  collexapp
//
//  Created by Lex on 22/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import FirebaseFirestore

class ChangeUniversityController: UIViewController {

    let db = Firestore.firestore().collection("users")
    
    var user: User!
    var university: University!
    var universityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        setupNavigationItems()
        universityTextField.text = user.university.name
        university = user.university
    }
    
    private func initialView() {
        let view = ChangeUniversityView(frame: self.view.frame)
        self.view = view
        universityTextField = view.universityTextField
    }
    
    @IBAction func handleUniversity(_ sender: Any?) {
        let universityController = UniversityController()
        let navigationController = UINavigationController(rootViewController: universityController)
        navigationController.modalPresentationStyle = .fullScreen
        let viewController = navigationController.topViewController as! UniversityController
        viewController.previousController = self
        viewController.isChangeUniversity = true
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func handleDismiss(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSave(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
        if user.university.name != university.name {
            self.db.document(self.user.id).updateData([
                "university": university.toJSON()
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
        titleLabel.text = "University"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    private func setupLeftNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ArrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(ChangeUniversityController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
    
    private func setupRightNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ChangeUniversityController.handleSave(_:)))
    }
}
