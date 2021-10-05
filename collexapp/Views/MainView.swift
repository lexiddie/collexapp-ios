//
//  MainView.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit

class MainView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(logoImage)
        addSubview(introLabel)
        addSubview(signUpButton)
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(infoLabel)
        containerStackView.addArrangedSubview(logInButton)
        setupDisplayLogo()
        setupIntro()
        setupSignUp()
        setupContainer()
    }
    
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "DisplayLogo").withRenderingMode(.alwaysOriginal)
        return image
    }()
    
    let introLabel: UILabel = {
        let label = UILabel()
        label.text = "Let’s explore the market place around your nearby university now."
        label.font = UIFont(name: "FiraSans-Bold", size: 30)
        label.textColor = UIColor.collexapp.mainBlack
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 4
        return label
    }()
    
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5
        return stackView
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up now", for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.collexapp.mainDarkRed
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(MainController.handleSignUp(_:)), for: .touchUpInside)
        return button
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
        button.addTarget(self, action: #selector(MainController.handleLogIn(_:)), for: .touchUpInside)
        return button
    }()
    
    private func setupDisplayLogo() {
        logoImage.snp.makeConstraints { (make) in
            if UIScreen.main.nativeBounds.width <= 640 {
                if #available(iOS 11.0, *) {
                    make.top.equalTo(self.safeAreaLayoutGuide).inset(50)
                } else {
                    make.top.equalTo(self).inset(50)
                }
                make.height.width.equalTo(90)
            } else if UIScreen.main.nativeBounds.width == 750 {
                if #available(iOS 11.0, *) {
                    make.top.equalTo(self.safeAreaLayoutGuide).inset(60)
                } else {
                    make.top.equalTo(self).inset(60)
                }
                make.height.width.equalTo(120)
            } else {
                if #available(iOS 11.0, *) {
                    make.top.equalTo(self.safeAreaLayoutGuide).inset(60)
                } else {
                    make.top.equalTo(self).inset(60)
                }
                make.height.width.equalTo(150)
            }
            make.centerX.equalTo(self)
        }
    }
    
    private func setupIntro() {
        introLabel.snp.makeConstraints{ (make) in
            make.height.equalTo(170)
            make.left.right.equalTo(self).inset(35)
            make.centerX.centerY.equalTo(self)
        }
    }
    
    private func setupSignUp() {
        signUpButton.snp.makeConstraints{ (make) in
            make.top.equalTo(introLabel.snp.bottom).offset(30)
            make.left.right.lessThanOrEqualTo(self).inset(30)
            make.height.equalTo(40)
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
