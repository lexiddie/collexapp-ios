//
//  UITextField.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import Hex

extension UITextField {
    
    public convenience init(placeholder: String, keyboardType: UIKeyboardType = UIKeyboardType.default, autoCorrectionType: UITextAutocorrectionType = UITextAutocorrectionType.no, autoCapitalizationType: UITextAutocapitalizationType = UITextAutocapitalizationType.none) {
        self.init()
        self.keyboardType = keyboardType
        self.autocorrectionType = autoCorrectionType
        self.autocapitalizationType = autoCapitalizationType
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.font = UIFont(name: "FiraSans-Regular", size: 15)
        self.textColor = UIColor.collexapp.mainBlack
        self.backgroundColor = UIColor.collexapp.mainLightWhite
        self.textAlignment = .left
        self.clearButtonMode = .whileEditing
        self.borderStyle = .none
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.collexapp.mainLightGrey.cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        self.leftViewMode = UITextField.ViewMode.always
    }
}

