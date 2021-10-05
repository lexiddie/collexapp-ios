//
//  ProfileView.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit

class EditProfileView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(profileView)
        setupProfileView()
        profileView.addSubview(profileImageView)
        profileView.addSubview(uploadProfileButton)
        setupProfileImageView()
        setupUploadProfileButton()
        addSubview(sectionView)
        sectionView.addSubview(lineView)
        sectionView.addSubview(nameStackView)
        sectionView.addSubview(nameLineView)
        sectionView.addSubview(usernameStackView)
        sectionView.addSubview(usernameLineView)
        sectionView.addSubview(messengerStackView)
        sectionView.addSubview(messengerLineView)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        usernameStackView.addArrangedSubview(usernameLabel)
        usernameStackView.addArrangedSubview(usernameTextField)
        messengerStackView.addArrangedSubview(messengerLabel)
        messengerStackView.addArrangedSubview(messengerTextField)
        setupSectionView()
        setupLineView()
        setupNameStackView()
        setupUsernameStackView()
        setupMessengerStackView()
    }
    
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
        button.addTarget(self, action: #selector(EditProfileController.handleUploadProfile(_:)), for: .touchUpInside)
        return button
    }()
    
    let sectionView: UIView = {
        let view = UIView()
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    
    let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.leading
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Full name"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        return label
    }()
    
    let nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "FiraSans-Regular", size: 17)
        textfield.textColor = UIColor.collexapp.mainBlack
        textfield.textAlignment = .left
        textfield.backgroundColor = UIColor.clear
        textfield.autocorrectionType = .no
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.attributedPlaceholder = NSAttributedString(string: "Full name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    let nameLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    let usernameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.leading
        return stackView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        return label
    }()
    
    let usernameTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "FiraSans-Regular", size: 17)
        textfield.textColor = UIColor.collexapp.mainBlack
        textfield.textAlignment = .left
        textfield.backgroundColor = UIColor.clear
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    let usernameLineView: UIView = {
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
        textfield.attributedPlaceholder = NSAttributedString(string: "Messenger ID", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    let messengerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    private func setupProfileView() {
        profileView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(70)
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
    
    private func setupSectionView() {
        sectionView.snp.makeConstraints { (make) in
            make.top.equalTo(profileView.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    private func setupLineView() {
        lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(sectionView)
            make.height.equalTo(0.5)
        }
    }
    
    private func setupNameStackView() {
        nameStackView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(25)
            make.left.right.lessThanOrEqualTo(sectionView).inset(30)
            make.height.equalTo(40)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameStackView)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        nameTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameStackView)
            make.height.equalTo(40)
            make.width.equalTo(self.frame.width - 160)
        }
        nameLineView.snp.makeConstraints { (make) in
            make.top.equalTo(nameStackView.snp.bottom).offset(5)
            make.right.equalTo(sectionView)
            make.height.equalTo(0.5)
            make.width.equalTo(self.frame.width - 130)
        }
    }
    
    private func setupUsernameStackView() {
        usernameStackView.snp.makeConstraints { (make) in
            make.top.equalTo(nameStackView.snp.bottom).offset(10)
            make.left.right.lessThanOrEqualTo(sectionView).inset(30)
            make.height.equalTo(40)
        }
        usernameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(usernameStackView)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        usernameTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(usernameStackView)
            make.height.equalTo(40)
            make.width.equalTo(self.frame.width - 160)
        }
        usernameLineView.snp.makeConstraints { (make) in
            make.top.equalTo(usernameStackView.snp.bottom).offset(5)
            make.right.equalTo(sectionView)
            make.height.equalTo(0.5)
            make.width.equalTo(self.frame.width - 130)
        }
    }
    
    private func setupMessengerStackView() {
        messengerStackView.snp.makeConstraints { (make) in
            make.top.equalTo(usernameStackView.snp.bottom).offset(10)
            make.left.right.lessThanOrEqualTo(sectionView).inset(30)
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
            make.right.equalTo(sectionView)
            make.height.equalTo(0.5)
            make.width.equalTo(self.frame.width - 130)
        }
    }

}
