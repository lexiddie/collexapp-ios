//
//  ChangeUniversityView.swift
//  collexapp
//
//  Created by Lex on 22/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class ChangeUniversityView: UIView {

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
        selectionView.addSubview(universityStackView)
        selectionView.addSubview(universityLineView)
        universityStackView.addArrangedSubview(universityLabel)
        universityStackView.addArrangedSubview(universityTextField)
        setupSelectionView()
        setupUniversityStackView()
    }

    let selectionView: UIView = {
        let view = UIView()
        return view
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
        textfield.addTarget(self, action: #selector(ChangeUniversityController.handleUniversity(_:)), for: .touchDown)
        return textfield
    }()
    
    let universityLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    
    private func setupSelectionView() {
        selectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    private func setupUniversityStackView() {
        universityStackView.snp.makeConstraints { (make) in
            make.top.equalTo(selectionView)
            make.left.right.lessThanOrEqualTo(selectionView).inset(30)
            make.height.equalTo(40)
        }
        universityLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(universityStackView)
            make.height.equalTo(40)
            make.width.equalTo(85)
        }
        universityTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(universityStackView)
            make.height.equalTo(40)
            make.width.equalTo(self.frame.width - 140)
        }
        universityLineView.snp.makeConstraints { (make) in
            make.top.equalTo(universityStackView.snp.bottom).offset(5)
            make.right.equalTo(selectionView)
            make.height.equalTo(0.5)
            make.width.equalTo(self.frame.width - 110)
        }
    }
}
