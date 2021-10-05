//
//  PrivateInformationView.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class PrivateInformationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(selectionView)
        selectionView.addSubview(googleStackView)
        selectionView.addSubview(googleLineView)
        googleStackView.addArrangedSubview(googleLabel)
        googleStackView.addArrangedSubview(googleTextField)
        setupSelectionView()
        setupGoogleStackView()
    }
    
    let selectionView: UIView = {
        let view = UIView()
        return view
    }()
    
    private func setupSelectionView() {
        selectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    let googleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.leading
        return stackView
    }()
    
    let googleLabel: UILabel = {
        let label = UILabel()
        label.text = "Google"
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        return label
    }()
    
    let googleTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "FiraSans-Regular", size: 17)
        textfield.textColor = UIColor.collexapp.mainBlack
        textfield.textAlignment = .left
        textfield.backgroundColor = UIColor.clear
        textfield.autocorrectionType = .no
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.attributedPlaceholder = NSAttributedString(string: "Google account", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    let googleLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    private func setupGoogleStackView() {
        googleStackView.snp.makeConstraints { (make) in
            make.top.equalTo(selectionView)
            make.left.right.lessThanOrEqualTo(selectionView).inset(30)
            make.height.equalTo(40)
        }
        googleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(googleStackView)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        googleTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(googleStackView)
            make.height.equalTo(40)
            make.width.equalTo(self.frame.width - 160)
        }
        googleLineView.snp.makeConstraints { (make) in
            make.top.equalTo(googleStackView.snp.bottom).offset(5)
            make.right.equalTo(self)
            make.height.equalTo(0.5)
            make.width.equalTo(self.frame.width - 130)
        }
    }


}
