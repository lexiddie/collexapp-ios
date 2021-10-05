//
//  HandleAlert.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class HandleAlert {
    
    func showAlert(title: String, alert: String, controller: UIViewController){
        let alertControl = UIAlertController(title: title, message: alert, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        alertControl.addAction(alertAction)
        controller.present(alertControl, animated: true, completion: nil)
    }
    
    func showLocationAccess(title: String, alert: String, controller: UIViewController) {
        let alertControl = UIAlertController(title: title, message: alert, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Not Now", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        alertControl.addAction(alertAction)
        alertControl.addAction(settingsAction)
        controller.present(alertControl, animated: true, completion: nil)
    }
    
    func showAlertDeleteProduct(title: String, alert: String, controller: UIViewController){
        let alertControl = UIAlertController(title: title, message: alert, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let viewController = controller as! CheckProductController
            viewController.deleteProduct()
            viewController.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        alertControl.addAction(alertAction)
        alertControl.addAction(cancelAction)
        controller.present(alertControl, animated: true, completion: nil)
    }
    
    func showAlertSoldProduct(title: String, alert: String, controller: UIViewController){
        let alertControl = UIAlertController(title: title, message: alert, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let viewController = controller as! CheckProductController
            viewController.soldProduct()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        alertControl.addAction(alertAction)
        alertControl.addAction(cancelAction)
        controller.present(alertControl, animated: true, completion: nil)
    }
    
    func showAlertSaveProduct(title: String, alert: String, controller: UIViewController){
        let alertControl = UIAlertController(title: title, message: alert, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let viewController = controller as! CheckProductController
            viewController.saveProduct()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        alertControl.addAction(alertAction)
        alertControl.addAction(cancelAction)
        controller.present(alertControl, animated: true, completion: nil)
    }
    
    func showAlertUnsaveProduct(title: String, alert: String, controller: UIViewController){
        let alertControl = UIAlertController(title: title, message: alert, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let viewController = controller as! CheckProductController
            viewController.unsavedProduct()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        alertControl.addAction(alertAction)
        alertControl.addAction(cancelAction)
        controller.present(alertControl, animated: true, completion: nil)
    }
}

