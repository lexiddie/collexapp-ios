//
//  ChangeCurrencyView.swift
//  collexapp
//
//  Created by Lex on 22/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class ChangeCurrencyView: UIView {

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
        selectionView.addSubview(currencyStackView)
        selectionView.addSubview(currencyLineView)
        currencyStackView.addArrangedSubview(currencyLabel)
        currencyStackView.addArrangedSubview(currencyTextField)
        setupSelectionView()
        setupCurrencyStackView()
    }

    let selectionView: UIView = {
        let view = UIView()
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
        textfield.backgroundColor = UIColor.clear
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.attributedPlaceholder = NSAttributedString(string: "Currency", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textfield.addTarget(self, action: #selector(ChangeCurrencyController.handleCurrency(_:)), for: .touchDown)
        return textfield
    }()
    
    let currencyLineView: UIView = {
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
    
    private func setupCurrencyStackView() {
        currencyStackView.snp.makeConstraints { (make) in
            make.top.equalTo(selectionView)
            make.left.right.lessThanOrEqualTo(selectionView).inset(30)
            make.height.equalTo(40)
        }
        currencyLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(currencyStackView)
            make.height.equalTo(40)
            make.width.equalTo(85)
        }
        currencyTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(currencyStackView)
            make.height.equalTo(40)
            make.width.equalTo(self.frame.width - 140)
        }
        currencyLineView.snp.makeConstraints { (make) in
            make.top.equalTo(currencyStackView.snp.bottom).offset(5)
            make.right.equalTo(selectionView)
            make.height.equalTo(0.5)
            make.width.equalTo(self.frame.width - 110)
        }
    }


}
