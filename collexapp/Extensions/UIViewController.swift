//
//  UIViewController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//
import UIKit

extension UIViewController {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

