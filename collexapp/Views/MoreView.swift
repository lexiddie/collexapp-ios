//
//  MoreView.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class MoreView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(scrollView)
        setupScrollView()
        scrollView.addSubview(moreView)
        setupMoreView()
        moreView.addSubview(profileView)
        setupProfileView()
        profileView.addSubview(profileImageView)
        setupProfileImageView()
        profileView.addSubview(profileStackView)
        setupProfileStackView()
        profileStackView.addArrangedSubview(nameLabel)
        profileStackView.addArrangedSubview(viewProfileButton)
        profileStackView.addArrangedSubview(viewMessengerButton)
        moreView.addSubview(containerStackView)
        setupContainerStackView()
        containerStackView.addArrangedSubview(accountView)
        containerStackView.addArrangedSubview(accountLabel)
        containerStackView.addArrangedSubview(privateInformationButton)
        containerStackView.addArrangedSubview(changePasswordButton)
        containerStackView.addArrangedSubview(searchHistoryButton)
        containerStackView.addArrangedSubview(universityButton)
        containerStackView.addArrangedSubview(currencyButton)
        containerStackView.addArrangedSubview(privacyView)
        containerStackView.addArrangedSubview(privacyLabel)
        containerStackView.addArrangedSubview(supportButton)
        containerStackView.addArrangedSubview(aboutView)
        containerStackView.addArrangedSubview(aboutLabel)
        containerStackView.addArrangedSubview(adsButton)
        containerStackView.addArrangedSubview(privacyPolicyButton)
        containerStackView.addArrangedSubview(loginView)
        containerStackView.addArrangedSubview(loginLabel)
        containerStackView.addArrangedSubview(logoutButton)
        setupSettingItems()
    }
    
    let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        return scrollview
    }()
    
    private func setupScrollView() {
        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    let moreView: UIView = {
        let view = UIView()
        return view
    }()
    
    private func setupMoreView() {
        moreView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(695)
        }
    }
    
    let profileView: UIView = {
        let view = UIView()
        return view
    }()
    
    private func setupProfileView() {
        profileView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(moreView)
            make.height.equalTo(100)
        }
    }
    
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.center
        return stackView
    }()
    
    private func setupContainerStackView() {
        containerStackView.snp.makeConstraints { (make) in
            make.top.equalTo(profileView.snp.bottom)
            make.left.right.bottom.equalTo(moreView)
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ProfileImage").withRenderingMode(.alwaysOriginal)
        imageView.layer.cornerRadius = 80/2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.leading
        stackView.distribution = UIStackView.Distribution.fillEqually
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Lex"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Bold", size: 17)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    let viewProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View profile", for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 15.5)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
        button.addTarget(self, action: #selector(MoreController.handleViewProfile(_:)), for: .touchUpInside)
        return button
    }()
    
    let viewMessengerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View messenger", for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 15.5)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.collexapp.mainBlue, for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
        button.addTarget(self, action: #selector(MoreController.handleViewMessenger(_:)), for: .touchUpInside)
        return button
    }()

    let accountView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "Account"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Bold", size: 17)
        return label
    }()
    
    let privateInformationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Private information", for: .normal)
        button.setTitleColor(UIColor.collexapp.mainBlack, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 16)
        button.backgroundColor = UIColor.clear
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        button.addTarget(self, action: #selector(MoreController.handlePrivateInfo(_:)), for: .touchUpInside)
        return button
    }()
    
    let changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change password", for: .normal)
        button.setTitleColor(UIColor.collexapp.mainBlack, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 16)
        button.backgroundColor = UIColor.clear
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        button.addTarget(self, action: #selector(MoreController.handleChangePassword(_:)), for: .touchUpInside)
        return button
    }()
    
    let searchHistoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search history", for: .normal)
        button.setTitleColor(UIColor.collexapp.mainBlack, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 16)
        button.backgroundColor = UIColor.clear
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        button.addTarget(self, action: #selector(MoreController.handleSearchHistory(_:)), for: .touchUpInside)
        return button
    }()
    
    let universityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("University:", for: .normal)
        button.setTitleColor(UIColor.collexapp.mainBlack, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 16)
        button.backgroundColor = UIColor.clear
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        button.addTarget(self, action: #selector(MoreController.handleUniversity(_:)), for: .touchUpInside)
//        let att = NSMutableAttributedString(string: "University: ABAC");
//        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.CollexApp.mainBlack, range: NSRange(location: 0, length: att.string.split(separator: " ")[0].count))
//        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSRange(location: 12, length: att.string.split(separator: " ")[1].count))
//        button.setAttributedTitle(att, for: .normal)
        return button
    }()
    
    let currencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Currency:", for: .normal)
        button.setTitleColor(UIColor.collexapp.mainBlack, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 16)
        button.backgroundColor = UIColor.clear
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        button.addTarget(self, action: #selector(MoreController.handleCurrency(_:)), for: .touchUpInside)
        return button
    }()
    
    let privacyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    let privacyLabel: UILabel = {
        let label = UILabel()
        label.text = "Privacy and security"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Bold", size: 17)
        label.textAlignment = .left
        return label
    }()
    
    let supportButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Support", for: .normal)
        button.setTitleColor(UIColor.collexapp.mainBlack, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 16)
        button.backgroundColor = UIColor.clear
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        button.addTarget(self, action: #selector(MoreController.handleSupport(_:)), for: .touchUpInside)
        return button
    }()
    
    let aboutView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "About"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Bold", size: 17)
        label.textAlignment = .left
        return label
    }()
    
    let adsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ads", for: .normal)
        button.setTitleColor(UIColor.collexapp.mainBlack, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 16)
        button.backgroundColor = UIColor.clear
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        button.addTarget(self, action: #selector(MoreController.handleAds(_:)), for: .touchUpInside)
        return button
    }()
    
    let privacyPolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Privacy policy ", for: .normal)
        button.setTitleColor(UIColor.collexapp.mainBlack, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "NotoSans", size: 16)
        button.backgroundColor = UIColor.clear
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        button.addTarget(self, action: #selector(MoreController.handlePrivacyPolicy(_:)), for: .touchUpInside)
        return button
    }()
    
    let loginView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Bold", size: 17)
        label.textAlignment = .left
        return label
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log out now", for: .normal)
        button.setTitleColor(UIColor.collexapp.mainRed, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 16)
        button.backgroundColor = UIColor.clear
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        button.addTarget(self, action: #selector(MoreController.handleLogOut(_:)), for: .touchUpInside)
        return button
    }()
    
    private func setupProfileImageView() {
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileView)
            make.height.width.equalTo(80)
            make.left.lessThanOrEqualTo(profileView).inset(20)
        }
    }
    
    private func setupProfileStackView() {
        profileStackView.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileView)
            make.height.equalTo(70)
            make.width.equalTo(self.frame.width - 140)
            make.left.equalTo(profileImageView.snp.right).offset(20)
            make.right.equalTo(profileView).inset(20)
        }
    }
    
    private func setupSettingItems() {
        accountView.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(0.5)
        }
        accountLabel.snp.makeConstraints { (make) in
            make.left.lessThanOrEqualTo(containerStackView).inset(20)
            make.height.equalTo(45)
        }
        privateInformationButton.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(45)
        }
        changePasswordButton.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(45)
        }
        searchHistoryButton.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(45)
        }
        universityButton.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(45)
        }
        currencyButton.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(45)
        }
        privacyView.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(0.5)
        }
        privacyLabel.snp.makeConstraints { (make) in
            make.left.right.lessThanOrEqualTo(containerStackView).inset(20)
            make.height.equalTo(45)
        }
        supportButton.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(45)
        }
        aboutView.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(0.5)
        }
        aboutLabel.snp.makeConstraints { (make) in
            make.left.right.lessThanOrEqualTo(containerStackView).inset(20)
            make.height.equalTo(45)
        }
        adsButton.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(45)
        }
        privacyPolicyButton.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(45)
        }
        loginView.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(0.5)
        }
        loginLabel.snp.makeConstraints { (make) in
            make.left.right.lessThanOrEqualTo(containerStackView).inset(20)
            make.height.equalTo(45)
        }
        logoutButton.snp.makeConstraints { (make) in
            make.width.equalTo(containerStackView.snp.width)
            make.height.equalTo(53)
        }
    }


}
