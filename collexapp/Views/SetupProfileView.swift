//
//  SetupProfileView.swift
//  collexapp
//
//  Created by Lex on 19/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit

class SetupProfileView: UIView {

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
        addSubview(profileView)
        setupTitle()
        setupProfileView()
        profileView.addSubview(profileImageView)
        profileView.addSubview(uploadProfileButton)
        setupProfileImageView()
        setupUploadProfileButton()
        addSubview(selectionView)
        selectionView.addSubview(lineView)
        selectionView.addSubview(contentLabel)
        selectionView.addSubview(universityStackView)
        selectionView.addSubview(universityLineView)
        selectionView.addSubview(currencyStackView)
        selectionView.addSubview(currencyLineView)
        selectionView.addSubview(messengerStackView)
        selectionView.addSubview(messengerLineView)
        selectionView.addSubview(signUpButton)
        universityStackView.addArrangedSubview(universityLabel)
        universityStackView.addArrangedSubview(universityTextField)
        currencyStackView.addArrangedSubview(currencyLabel)
        currencyStackView.addArrangedSubview(currencyTextField)
        messengerStackView.addArrangedSubview(messengerLabel)
        messengerStackView.addArrangedSubview(messengerTextField)
        setupSelectionView()
        setupLineView()
        setupContentLabel()
        setupUniversityStackView()
        setupCurrencyStackView()
        setupMessengerStackView()
        setupSignUpButton()
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Setup a profile"
        label.font = UIFont(name: "FiraSans-Bold", size: 30)
        label.textColor = UIColor.collexapp.mainBlack
        label.textAlignment = .center
        return label
    }()
    
    let profileView: UIView = {
        let view = UIView()
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ProfileImage").withRenderingMode(.alwaysOriginal)
        imageView.layer.cornerRadius = 120/2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let uploadProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload profile photo", for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Bold", size: 16)
        button.setTitleColor(UIColor.collexapp.mainDarkRed, for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(SetupProfileController.handleUploadProfile(_:)), for: .touchUpInside)
        return button
    }()
    
    let selectionView: UIView = {
        let view = UIView()
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "Content"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Bold", size: 18)
        label.textAlignment = .left
        return label
    }()
    
    let universityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.leading
        return stackView
    }()
    
    let universityLabel: UILabel = {
        let label = UILabel()
        label.text = "University"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        return label
    }()
    
    let universityTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "FiraSans-Regular", size: 17)
        textfield.textColor = UIColor.collexapp.mainBlack
        textfield.textAlignment = .left
        textfield.backgroundColor = UIColor.clear
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.attributedPlaceholder = NSAttributedString(string: "University", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textfield.addTarget(self, action: #selector(SetupProfileController.handleUniversity(_:)), for: .touchDown)
        return textfield
    }()
    
    let universityLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    let currencyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.leading
        return stackView
    }()
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Currency"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        return label
    }()
    
    let currencyTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "FiraSans-Regular", size: 17)
        textfield.textColor = UIColor.collexapp.mainBlack
        textfield.textAlignment = .left
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.backgroundColor = UIColor.clear
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.attributedPlaceholder = NSAttributedString(string: "Currency", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textfield.addTarget(self, action: #selector(SetupProfileController.handleCurrency(_:)), for: .touchDown)
        return textfield
    }()
    
    let currencyLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    let messengerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.leading
        return stackView
    }()
    
    let messengerLabel: UILabel = {
        let label = UILabel()
        label.text = "Messenger"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        return label
    }()
    
    let messengerTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "FiraSans-Regular", size: 17)
        textfield.textColor = UIColor.collexapp.mainBlack
        textfield.textAlignment = .left
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.backgroundColor = UIColor.clear
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.attributedPlaceholder = NSAttributedString(string: "Messenger", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    let messengerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 17)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.collexapp.mainDarkRed
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(SetupProfileController.handleSignUp(_:)), for: .touchUpInside)
        return button
    }()
    
    private func setupTitle() {
        titleLabel.snp.makeConstraints{ (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.safeAreaLayoutGuide).inset(60)
            } else {
                make.top.equalTo(self).inset(60)
            }
            make.centerX.equalTo(self)
        }
    }
    
    private func setupProfileView() {
        profileView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(215)
        }
    }
    
    private func setupProfileImageView() {
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(profileView).inset(30)
            make.centerX.equalTo(profileView)
            make.height.width.equalTo(120)
        }
    }
    
    private func setupUploadProfileButton() {
        uploadProfileButton.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(15)
            make.centerX.equalTo(profileView)
            make.height.equalTo(40)
        }
    }
    
    private func setupSelectionView() {
        selectionView.snp.makeConstraints { (make) in
            make.top.equalTo(profileView.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    private func setupLineView() {
        lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(selectionView)
            make.height.equalTo(0.5)
        }
    }
    
    private func setupContentLabel() {
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(15)
            make.left.right.lessThanOrEqualTo(selectionView).inset(25)
        }
    }
    
    private func setupUniversityStackView() {
        universityStackView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.right.lessThanOrEqualTo(selectionView).inset(30)
            make.height.equalTo(40)
        }
        universityLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(universityStackView)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        universityTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(universityStackView)
            make.height.equalTo(40)
            make.width.equalTo(self.frame.width - 160)
        }
        universityLineView.snp.makeConstraints { (make) in
            make.top.equalTo(universityStackView.snp.bottom).offset(5)
            make.right.equalTo(selectionView)
            make.height.equalTo(0.5)
            make.width.equalTo(self.frame.width - 130)
        }
    }
    
    private func setupCurrencyStackView() {
        currencyStackView.snp.makeConstraints { (make) in
            make.top.equalTo(universityStackView.snp.bottom).offset(10)
            make.left.right.lessThanOrEqualTo(selectionView).inset(30)
            make.height.equalTo(40)
        }
        currencyLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(currencyStackView)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        currencyTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(currencyStackView)
            make.height.equalTo(40)
            make.width.equalTo(self.frame.width - 160)
        }
        currencyLineView.snp.makeConstraints { (make) in
            make.top.equalTo(currencyStackView.snp.bottom).offset(5)
            make.right.equalTo(selectionView)
            make.height.equalTo(0.5)
            make.width.equalTo(self.frame.width - 130)
        }
    }
    
    private func setupMessengerStackView() {
        messengerStackView.snp.makeConstraints { (make) in
            make.top.equalTo(currencyStackView.snp.bottom).offset(10)
            make.left.right.lessThanOrEqualTo(selectionView).inset(30)
            make.height.equalTo(40)
        }
        messengerLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(messengerStackView)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        messengerTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(messengerStackView)
            make.height.equalTo(40)
            make.width.equalTo(self.frame.width - 160)
        }
        messengerLineView.snp.makeConstraints { (make) in
            make.top.equalTo(messengerStackView.snp.bottom).offset(5)
            make.right.equalTo(selectionView)
            make.height.equalTo(0.5)
            make.width.equalTo(self.frame.width - 130)
        }
    }
    
    private func setupSignUpButton() {
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(messengerTextField.snp.bottom).offset(40)
            make.left.right.lessThanOrEqualTo(selectionView).inset(30)
            make.height.equalTo(40)
            make.centerX.equalTo(selectionView)
        }
    }

}
