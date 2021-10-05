//
//  SetupAccountView.swift
//  collexapp
//
//  Created by Lex on 19/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class SetupAccountView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(titleLabel)
        addSubview(nameLabel)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(nextButton)
        setupTitle()
        setupName()
        setupUsername()
        setupPassword()
        setupConfirmPassword()
        setupNext()
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Setup your account"
        label.font = UIFont(name: "FiraSans-Bold", size: 30)
        label.textColor = UIColor.collexapp.mainBlack
        label.textAlignment = .center
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FiraSans-Regular", size: 20)
        label.textColor = UIColor.collexapp.mainBlack
        label.textAlignment = .left
        return label
    }()
    
    let usernameTextField: UITextField = {
        let textfield = UITextField(placeholder: "Username", keyboardType: UIKeyboardType.default, autoCorrectionType: UITextAutocorrectionType.no, autoCapitalizationType: UITextAutocapitalizationType.none)
        textfield.textContentType = UITextContentType.username
        return textfield
    }()
    
    let passwordTextField: UITextField = {
        let textfield = UITextField(placeholder: "Password")
        textfield.textContentType = UITextContentType.password
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    let confirmPasswordTextField: UITextField = {
        let textfield = UITextField(placeholder: "Confirm password")
        textfield.textContentType = UITextContentType.password
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 17)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.collexapp.mainDarkRed
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(SetupAccountController.handleNext(_:)), for: .touchUpInside)
        return button
    }()
    
    
    private func setupTitle() {
        titleLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(60)
            make.centerX.equalTo(self)
        }
    }
    
    private func setupName() {
        nameLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.right.lessThanOrEqualTo(self).inset(30)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
        }
    }
    
    private func setupUsername() {
        usernameTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(40)
            make.left.right.lessThanOrEqualTo(self).inset(30)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
        }
    }
    
    private func setupPassword() {
        passwordTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.centerX.equalTo(self)
            make.left.right.lessThanOrEqualTo(self).inset(30)
        }
    }
    
    private func setupConfirmPassword() {
        confirmPasswordTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.centerX.equalTo(self)
            make.left.right.lessThanOrEqualTo(self).inset(30)
        }
    }
    
    private func setupNext() {
        nextButton.snp.makeConstraints{ (make) in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(30)
            make.height.equalTo(40)
            make.left.right.lessThanOrEqualTo(self).inset(30)
            make.centerX.equalTo(self)
        }
    }
}
