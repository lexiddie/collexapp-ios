//
//  SignUpView.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit
import GoogleSignIn

class SignUpView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(logoButton)
        addSubview(titleLabel)
        addSubview(googleSignUp)
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(infoLabel)
        containerStackView.addArrangedSubview(logInButton)
        setupLogo()
        setupTitle()
        setupGoogleSignUp()
        setupContainer()
    }
    
    let logoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "DisplayLogo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(SignUpController.handleLogo(_:)), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your account"
        label.font = UIFont(name: "FiraSans-Bold", size: 30)
        label.textColor = UIColor.collexapp.mainBlack
        label.textAlignment = .center
        return label
    }()
    
    let googleSignUp: GIDSignInButton = {
        let button = GIDSignInButton()
        button.backgroundColor = UIColor.collexapp.mainDarkRed
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(SignUpController.handleGoogleSignUp(_:)), for: .touchUpInside)
        return button
    }()
    
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5
        return stackView
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Have an account?"
        label.font = UIFont(name: "FiraSans-Regular", size: 14)
        label.textColor = UIColor.collexapp.mainGrey
        return label
    }()
    
    let logInButton: UIButton = {
        let button = UIButton (type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 15)
        button.setTitleColor(UIColor.collexapp.mainDarkRed, for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(SignUpController.handleLogIn(_:)), for: .touchUpInside)
        return button
    }()
    
    private func setupLogo() {
        logoButton.snp.makeConstraints{ (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.safeAreaLayoutGuide).inset(30)
            } else {
                make.top.equalTo(self).inset(30)
            }
            make.height.width.equalTo(70)
            make.centerX.equalTo(self)
        }
    }
    
    private func setupTitle() {
        titleLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(logoButton.snp.bottom).offset(30)
            make.centerX.equalTo(self)
        }
    }
    
    
    private func setupGoogleSignUp() {
        googleSignUp.snp.makeConstraints{ (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(80)
            make.height.equalTo(40)
            make.left.right.lessThanOrEqualTo(self).inset(30)
            make.centerX.equalTo(self)
        }
    }
    
    private func setupContainer() {
        containerStackView.snp.makeConstraints{ (make) in
            make.centerX.equalTo(self)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            } else {
                make.bottom.equalTo(self).inset(20)
            }
            make.height.equalTo(30)
            make.width.equalTo(165)
        }
    }

}
