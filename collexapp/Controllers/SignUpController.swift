//
//  SignUpController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import GoogleSignIn
import ObjectMapper

class SignUpController: UIViewController, GIDSignInDelegate {
    
    private let defaults = UserDefaults.standard
    let db = Firestore.firestore()
    var previousController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        initialView()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID!               // For client-side use only!
//        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name!
//        let givenName = user.profile.givenName
//        let familyName = user.profile.familyName
        let email = user.profile.email!
        print("This is my signin email \(String(email))")
        print("This is my fullname \(String(fullName))")
        print("Checking userID \(String(userId))")
        checkExistsGoogleAccount(user: user)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.isNavigationBarHidden = true
    }
    
    private func initialView() {
        let view = SignUpView(frame: self.view.frame)
        self.view = view
    }
    
    @IBAction func handleLogo(_ sender: Any?) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func handleGoogleSignUp(_ sender: Any?) {
        print("Click Google SignUp")
    }
    
    @IBAction func handleNext(_ sender: Any?) {

    }
    
    @IBAction func handleLogIn(_ sender: Any?) {
        guard let mainControllers: [UIViewController] = self.navigationController?.viewControllers else { return }
        if previousController == mainControllers[0] {
            let logInController = LogInController()
            logInController.previousController = self
            self.navigationController?.pushViewController(logInController, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func checkExistsGoogleAccount(user: GIDGoogleUser) {
        db.collection("users")
            .whereField("email.id", in: [user.profile.email!])
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if querySnapshot!.documents.count == 0 {
                    let viewController = SetupAccountController()
                    viewController.userGoogle = user
                    self.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    for document in querySnapshot!.documents {
                        let user = Mapper<User>().map(JSONObject: document.data())!
                        let userJson = Mapper().toJSONString(user, prettyPrint: true)!
                        print("Current data: \(userJson)")
                        let initiateUser = ["login": true, "id": user.id!] as [String: Any]
                        self.defaults.set(initiateUser, forKey: "user")
                        let mainTabBarController = MainTabBarController()
                        mainTabBarController.user = user
                        mainTabBarController.modalPresentationStyle = .fullScreen
                        self.present(mainTabBarController, animated: true, completion: nil)
                        return
                    }
                }
            }
        }
    }
    
}
