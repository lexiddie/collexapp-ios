//
//  MainTabBarController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import HorizonCalendar

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.white
        setupTabBar()
    }
    
    private func setupTabBar() {
//        let homeNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "HomeUnselected"), selectedImage: #imageLiteral(resourceName: "HomeSelected"), rootViewController: HomeController())
//        let saveNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "SaveUnselected"), selectedImage: #imageLiteral(resourceName: "SaveSelected"), rootViewController: SaveController())
//        let createNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "CreateUnselected"), selectedImage: #imageLiteral(resourceName: "CreateSelected"), rootViewController: CreateController())
//        let listingNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "ListingUnselected"), selectedImage: #imageLiteral(resourceName: "ListingSelected"), rootViewController: ListingController())
//        let moreNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "MoreUnselected"), selectedImage: #imageLiteral(resourceName: "MoreSelected"), rootViewController: MoreController())
//
//        viewControllers = [homeNavigation, saveNavigation, createNavigation, listingNavigation, moreNavigation]
        

//        let layout = UICollectionViewFlowLayout()
//        let exploreController = ExploreController(collectionViewLayout: layout)
//        let homeNavigation = UINavigationController(rootViewController: exploreController)
//        homeNavigation.tabBarItem.image = #imageLiteral(resourceName: "HomeUnselected")
//        homeNavigation.tabBarItem.selectedImage = #imageLiteral(resourceName: "HomeSelected")
        
//        let homeNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "HomeUnselected"), selectedImage: #imageLiteral(resourceName: "HomeSelected"), rootViewController: ExploreController())
        
        let homeNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "HomeUnselected"), selectedImage: #imageLiteral(resourceName: "HomeSelected"), rootViewController: HomeController())
//        let savedNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "SavedUnselected"), selectedImage: #imageLiteral(resourceName: "SavedSelected"), rootViewController: SavedController())
        let savedNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "SavedUnselected"), selectedImage: #imageLiteral(resourceName: "SavedSelected"), rootViewController: SingleDayController())
        let listNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "ListSelected"), selectedImage: #imageLiteral(resourceName: "ListUnselected"), rootViewController: ListController())
        let notificationsNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "NotificationsUnselected"), selectedImage: #imageLiteral(resourceName: "NotificationsSelected"), rootViewController: NotificationsController())
        let profileNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "ProfileUnselected"), selectedImage: #imageLiteral(resourceName: "ProfileSelected"), rootViewController: MoreController())
//        let profileNavigation = templateNavController(unselectImage: #imageLiteral(resourceName: "ProfileUnselected"), selectedImage: #imageLiteral(resourceName: "ProfileSelected"), rootViewController: ProfileController())
        
//        let layout = UICollectionViewFlowLayout()
//        let listController = ProfileCollectionController(collectionViewLayout: layout)
//
//        let listNavigation = UINavigationController(rootViewController: listController)
//
//        listNavigation.tabBarItem.image = #imageLiteral(resourceName: "ListSelected")
//        listNavigation.tabBarItem.selectedImage = #imageLiteral(resourceName: "ListUnselected")
        
        
        viewControllers = [homeNavigation, savedNavigation, listNavigation, notificationsNavigation, profileNavigation]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
    }
    
    private func templateNavController(unselectImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewNavigation = UINavigationController(rootViewController: rootViewController)
        viewNavigation.tabBarItem.image = unselectImage.withRenderingMode(.alwaysOriginal)
        viewNavigation.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        viewNavigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        viewNavigation.navigationBar.isTranslucent = false
        viewNavigation.navigationBar.barTintColor = UIColor.collexapp.mainLightWhite
        return viewNavigation
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            print("Create Controller")
            let creatController = CreateController()
            creatController.user = self.user
            let navigationController = UINavigationController(rootViewController: creatController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
            return false
        }
        return true
    }
}
