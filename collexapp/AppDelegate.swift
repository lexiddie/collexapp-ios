//
//  AppDelegate.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseCore
import GoogleMaps
import GooglePlaces
import FirebaseAuth
import GoogleSignIn
import Cache
import ObjectMapper


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = "661565228186-geu1s3deigt38ooubl2sratgsna8rkmh.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        GMSServices.provideAPIKey("AIzaSyCEAxsyk447vlS2_sj_8iHeGbmxKJXi_BE")
        GMSPlacesClient.provideAPIKey("AIzaSyCjmvo9DKJnDRElqcd-kMm7GLEAvp8qOG8")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }

        let defaults = UserDefaults.standard
        let user = defaults.object(forKey: "user")
        if let check = user as? [String: Any] {
            let login = check["login"] as! Bool
            if login {
                let mainTabBarController = MainTabBarController()
                if let userCache: User = FCache.get("userInfo"), !FCache.isExpired("userInfo") {
                    mainTabBarController.user = userCache
                    let userJson = Mapper().toJSONString(userCache, prettyPrint: true)!
                    print("Cache UserInfo: \(userJson)")
                }
                window?.rootViewController = mainTabBarController
            } else {
                window?.rootViewController = UINavigationController(rootViewController: MainController())
            }
        } else {
            window?.rootViewController = UINavigationController(rootViewController: MainController())
        }
        
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        print("User email: \(user.profile.email ?? "No email")")
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        }
        // Perform any operations on signed in user here.
        // For client-side use only!
        let userId = user.userID
        // Safe to send to the server
//        let idToken = user.authentication.idToken
//        let fullName = user.profile.name
//        let givenName = user.profile.givenName
//        let familyName = user.profile.familyName
//        let email = user.profile.email
        print("Checking userID \(String(userId!))")
        // ...
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

