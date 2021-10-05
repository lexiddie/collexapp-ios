//
//  ChangePasswordView.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class ChangePasswordView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(currentPasswordTextField)
        setupCurrentPasswordTextField()
        addSubview(currentPasswordLineView)
        setupCurrentPasswordLineView()
        addSubview(newPasswordTextField)
        setupNewPasswordTextField()
        addSubview(newPasswordLineView)
        setupNewPasswordLineView()
        addSubview(verifyPasswordTextField)
        setupVerifyPasswordTextField()
        addSubview(verifyPasswordLineView)
        setupVerifyPasswordLineView()
    }
    
    let currentPasswordTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "FiraSans-Regular", size: 17)
        textfield.textColor = UIColor.collexapp.mainBlack
        textfield.textAlignment = .left
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.backgroundColor = UIColor.clear
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.textContentType = UITextContentType.password
        textfield.isSecureTextEntry = true
        textfield.attributedPlaceholder = NSAttributedString(string: "Current password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    private func setupCurrentPasswordTextField() {
        currentPasswordTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.left.right.lessThanOrEqualTo(self).inset(10)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
        }
    }
    
    let currentPasswordLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    private func setupCurrentPasswordLineView() {
        currentPasswordLineView.snp.makeConstraints { (make) in
            make.top.equalTo(currentPasswordTextField.snp.bottom).offset(5)
            make.left.right.lessThanOrEqualTo(self).inset(10)
            make.height.equalTo(0.5)
        }
    }
    
    let newPasswordTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "FiraSans-Regular", size: 17)
        textfield.textColor = UIColor.collexapp.mainBlack
        textfield.textAlignment = .left
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.backgroundColor = UIColor.clear
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.textContentType = UITextContentType.password
        textfield.isSecureTextEntry = true
        textfield.attributedPlaceholder = NSAttributedString(string: "New password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    private func setupNewPasswordTextField() {
        newPasswordTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(currentPasswordLineView)
            make.left.right.lessThanOrEqualTo(self).inset(10)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
        }
    }
    
    let newPasswordLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    private func setupNewPasswordLineView() {
        newPasswordLineView.snp.makeConstraints { (make) in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(5)
            make.left.right.lessThanOrEqualTo(self).inset(10)
            make.height.equalTo(0.5)
        }
    }
    
    let verifyPasswordTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "FiraSans-Regular", size: 17)
        textfield.textColor = UIColor.collexapp.mainBlack
        textfield.textAlignment = .left
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.backgroundColor = UIColor.clear
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.textContentType = UITextContentType.password
        textfield.isSecureTextEntry = true
        textfield.attributedPlaceholder = NSAttributedString(string: "Verify password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    private func setupVerifyPasswordTextField() {
        verifyPasswordTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(newPasswordLineView)
            make.left.right.lessThanOrEqualTo(self).inset(10)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
        }
    }
    
    let verifyPasswordLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    private func setupVerifyPasswordLineView() {
        verifyPasswordLineView.snp.makeConstraints { (make) in
            make.top.equalTo(verifyPasswordLineView.snp.bottom).offset(5)
            make.left.right.lessThanOrEqualTo(self).inset(10)
            make.height.equalTo(0.5)
        }
    }


}
