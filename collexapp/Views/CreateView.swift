//
//  CreateView.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit
import ImageSlideshow

class CreateView: UIView {

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
        scrollView.addSubview(createView)
        setupCreateView()
        createView.addSubview(profileView)
        setupProfileView()
        profileView.addSubview(profileImageView)
        setupProfileImageView()
        profileView.addSubview(profileStackView)
        setupProfileStackView()
        profileStackView.addArrangedSubview(nameLabel)
        profileStackView.addArrangedSubview(universityNameLabel)
        profileStackView.addArrangedSubview(viewMessengerButton)
        createView.addSubview(productImageSlideShow)
        setupProductImageSlideShow()
        createView.addSubview(addPhotosButton)
        setupAddPhotosButton()
        createView.addSubview(productNameTextField)
        setupProductNameTextField()
        createView.addSubview(productPriceTextField)
        setupProductPriceTextField()
        createView.addSubview(productConditionTextField)
        setupProductConditionTextField()
        createView.addSubview(productCategoryTextField)
        setupProductCategoryTextField()
        createView.addSubview(productLocationTextField)
        setupProductLocationTextField()
        createView.addSubview(productDescriptionTextView)
        setupProductDescriptionTextView()
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
    
    let createView: UIView = {
        let view = UIView()
        return view
    }()
    
    let profileView: UIView = {
        let view = UIView()
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ProfileImage").withRenderingMode(.alwaysOriginal)
        imageView.layer.cornerRadius = 70/2
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
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Bold", size: 17)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    
    let universityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    let viewMessengerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View messenger", for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 15.5)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.collexapp.mainBlue, for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
        button.addTarget(self, action: #selector(CreateController.handleViewMessenger(_:)), for: .touchUpInside)
        return button
    }()
    
    let productImageSlideShow: ImageSlideshow = {
        let imageSlideShow = ImageSlideshow()
        imageSlideShow.setImageInputs([ImageSource(image: #imageLiteral(resourceName: "DefaultPhoto").withRenderingMode(.alwaysOriginal))])
        imageSlideShow.layer.cornerRadius = 5
        imageSlideShow.layer.borderWidth = 1
        imageSlideShow.layer.borderColor = UIColor.collexapp.mainLightGrey.cgColor
        imageSlideShow.backgroundColor = UIColor.collexapp.mainLightWhite
        imageSlideShow.clipsToBounds = true
        imageSlideShow.zoomEnabled = false
        imageSlideShow.contentScaleMode = .scaleAspectFill
        return imageSlideShow
    }()
    
    let addPhotosButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add photos", for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraSans-Bold", size: 16)
        button.setTitleColor(UIColor.collexapp.mainDarkRed, for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(CreateController.handleAddPhotos(_:)), for: .touchUpInside)
        return button
    }()
    
    private func setupAddPhotosButton() {
        addPhotosButton.snp.makeConstraints { (make) in
            make.top.equalTo(productImageSlideShow.snp.bottom).offset(15)
            make.centerX.equalTo(profileView)
            make.height.equalTo(40)
        }
    }
    
    let productNameTextField: UITextField = {
        let textfield = UITextField(placeholder: "Product name", keyboardType: UIKeyboardType.default, autoCorrectionType: UITextAutocorrectionType.no, autoCapitalizationType: UITextAutocapitalizationType.words)
        return textfield
    }()
    
    private func setupProductNameTextField() {
        productNameTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(addPhotosButton.snp.bottom).offset(20)
            make.left.right.lessThanOrEqualTo(createView).inset(20)
            make.centerX.equalTo(createView)
            make.height.equalTo(50)
        }
    }
    
    let productPriceTextField: UITextField = {
        let textfield = UITextField(placeholder: "Product price", keyboardType: UIKeyboardType.numberPad, autoCorrectionType: UITextAutocorrectionType.no, autoCapitalizationType: UITextAutocapitalizationType.none)
        return textfield
    }()
    
    private func setupProductPriceTextField() {
        productPriceTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(productNameTextField.snp.bottom).offset(20)
            make.left.right.lessThanOrEqualTo(createView).inset(20)
            make.centerX.equalTo(createView)
            make.height.equalTo(50)
        }
    }
    
    let productConditionTextField: UITextField = {
        let textfield = UITextField(placeholder: "Condition", keyboardType: UIKeyboardType.default, autoCorrectionType: UITextAutocorrectionType.no, autoCapitalizationType: UITextAutocapitalizationType.none)
        textfield.addTarget(self, action: #selector(CreateController.handlePickCondition(_:)), for: .touchDown)
        return textfield
    }()
    
    private func setupProductConditionTextField() {
        productConditionTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(productPriceTextField.snp.bottom).offset(20)
            make.left.right.lessThanOrEqualTo(createView).inset(20)
            make.centerX.equalTo(createView)
            make.height.equalTo(50)
        }
    }
    
    let productCategoryTextField: UITextField = {
        let textfield = UITextField(placeholder: "Category", keyboardType: UIKeyboardType.default, autoCorrectionType: UITextAutocorrectionType.no, autoCapitalizationType: UITextAutocapitalizationType.none)
        textfield.addTarget(self, action: #selector(CreateController.handlePickCategory(_:)), for: .touchDown)
        return textfield
    }()
    
    private func setupProductCategoryTextField() {
        productCategoryTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(productConditionTextField.snp.bottom).offset(20)
            make.left.right.lessThanOrEqualTo(createView).inset(20)
            make.centerX.equalTo(createView)
            make.height.equalTo(50)
        }
    }
    
    let productLocationTextField: UITextField = {
        let textfield = UITextField(placeholder: "Location", keyboardType: UIKeyboardType.default, autoCorrectionType: UITextAutocorrectionType.no, autoCapitalizationType: UITextAutocapitalizationType.none)
        textfield.addTarget(self, action: #selector(CreateController.handlePickLocation(_:)), for: .touchDown)
        return textfield
    }()
    
    private func setupProductLocationTextField() {
        productLocationTextField.snp.makeConstraints{ (make) in
            make.top.equalTo(productCategoryTextField.snp.bottom).offset(20)
            make.left.right.lessThanOrEqualTo(createView).inset(20)
            make.centerX.equalTo(createView)
            make.height.equalTo(50)
        }
    }
    
    let productDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.gray
        textView.text = "Product's description"
        textView.font = UIFont(name: "FiraSans-Regular", size: 16)
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.collexapp.mainLightGrey.cgColor
        textView.backgroundColor = UIColor.collexapp.mainLightWhite
        textView.isScrollEnabled = true
        return textView
    }()

    private func setupProductDescriptionTextView() {
        productDescriptionTextView.snp.makeConstraints{ (make) in
            make.top.equalTo(productLocationTextField.snp.bottom).offset(20)
            make.left.right.lessThanOrEqualTo(createView).inset(20)
            make.centerX.equalTo(createView)
            make.height.equalTo(200)
        }
    }
    
    //725 without Textview
    private func setupCreateView() {
        createView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(945)
        }
    }
    
    private func setupProfileView() {
        profileView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(createView)
            make.height.equalTo(100)
        }
    }
    
    private func setupProfileImageView() {
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileView)
            make.height.width.equalTo(70)
            make.left.lessThanOrEqualTo(profileView).inset(20)
        }
    }
    
    private func setupProfileStackView() {
        profileStackView.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileView)
            make.height.equalTo(70)
            make.width.equalTo(self.frame.width - 130)
            make.left.equalTo(profileImageView.snp.right).offset(20)
            make.right.equalTo(profileView).inset(20)
        }
    }
    
    private func setupProductImageSlideShow() {
        productImageSlideShow.snp.makeConstraints { (make) in
            make.top.equalTo(profileView.snp.bottom).offset(20)
            make.left.right.lessThanOrEqualTo(createView).inset(20)
            make.centerX.equalTo(createView)
            make.height.equalTo(200)
        }
    }
    
}
