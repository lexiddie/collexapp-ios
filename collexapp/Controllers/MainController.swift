//
//  MainController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import CryptoSwift

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        handleHashData()
        print("MainController Loaded")
        let getDateTime = HandleDateTime().getDateTime()
        print(getDateTime)
    }
    
    private func handleHashData() {
        let value = "thisismypassword"
        
        let hash = value.sha256()
        print("This is SHA256 \(String(hash))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func initialView() {
        let mainView = MainView(frame: self.view.frame)
        self.view = mainView
    }
    
    @IBAction func handleSignUp(_ sender: Any?) {
        let signUpController = SignUpController()
        signUpController.previousController = self
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    @IBAction func handleLogIn(_ sender: Any?) {
        let logInController = LogInController()
        logInController.previousController = self
        navigationController?.pushViewController(logInController, animated: true)
    }
}
