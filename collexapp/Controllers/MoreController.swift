//
//  MoreController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Alamofire
import AlamofireImage

class MoreController: UIViewController  {

    private let alert = HandleAlert()
    private let attribute = HandleAttribute()
    private let defaults = UserDefaults.standard
    var user: User!
    var nameLabel: UILabel!
    var profileImageView: UIImageView!
    var universityButton: UIButton!
    var currencyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let mainTabBarController = self.tabBarController as! MainTabBarController
        user = mainTabBarController.user
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
        universityButton.setAttributedTitle(attribute.getStringAttributed(mainString: "University", secondString: userInfo.university.name), for: .normal)
        currencyButton.setAttributedTitle(attribute.getStringAttributed(mainString: "Currency", secondString: "\(userInfo.currency.code!) - \(userInfo.currency.name!)"), for: .normal)
        setupTitleNavItem(username: user.username)
    }
    
    private func setupTitleNavItem(username: String) {
        let titleLabel = UILabel()
        titleLabel.text = username
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }

    private func initialView() {
        let view = MoreView(frame: self.view.frame)
        self.view = view
        nameLabel = view.nameLabel
        profileImageView = view.profileImageView
        universityButton = view.universityButton
        currencyButton = view.currencyButton
    }
    
    @IBAction func handleViewProfile(_ sender: Any?) {
        let profileController = EditProfileController()
        profileController.user = user
        let navigationController = UINavigationController(rootViewController: profileController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func handleViewMessenger(_ sender: Any?) {
        if let url = URL(string: "https://m.me/\(String(user.socialNetworks[0].username))") {
            UIApplication.shared.open(url, options: [:],completionHandler:nil)
        }
    }
    
    @IBAction func handlePrivateInfo(_ sender: Any?) {
        let privateInformationController = PrivateInformationController()
        privateInformationController.user = user
        let navigationController = UINavigationController(rootViewController: privateInformationController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func handleChangePassword(_ sender: Any?) {
        let changePasswordController = ChangePasswordController()
        changePasswordController.user = user
        let navigationController = UINavigationController(rootViewController: changePasswordController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func handleSearchHistory(_ sender: Any?) {
        print("123")
    }
    
    @IBAction func handleUniversity(_ sender: Any?) {
        let changeUniversityController = ChangeUniversityController()
        changeUniversityController.user = user
        let navigationController = UINavigationController(rootViewController: changeUniversityController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func handleCurrency(_ sender: Any?) {
        let changeCurrencyController = ChangeCurrencyController()
        changeCurrencyController.user = user
        let navigationController = UINavigationController(rootViewController: changeCurrencyController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func handleSupport(_ sender: Any?) {
         
    }
    
    @IBAction func handleAds(_ sender: Any?) {

    }
    
    @IBAction func handlePrivacyPolicy(_ sender: Any?) {
        print("123")
    }
    
    @IBAction func handleLogOut(_ sender: Any?) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let title = NSAttributedString(string: "Would you like to log out?", attributes: [NSAttributedString.Key.font: UIFont(name: "FiraSans-Bold", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        alertController.setValue(title, forKey: "attributedMessage")
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            let initiateUser = ["login": false]
            self.defaults.set(initiateUser, forKey: "user")
            let mainController = MainController()
            let navController = UINavigationController(rootViewController: mainController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
