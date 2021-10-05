//
//  PickCategoryView.swift
//  collexapp
//
//  Created by Lex on 23/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit

class CategoryView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(categoryTableView)
        categoryTableView.snp.makeConstraints { (make) in
            make.top.bottom.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
            make.left.right.lessThanOrEqualTo(self)
        }
        addSubview(friendlyLabel)
        friendlyLabel.snp.makeConstraints{ (make) in
            make.left.right.equalTo(categoryTableView).inset(35)
            make.centerX.centerY.equalTo(categoryTableView)
        }
    }
    
    let categoryTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        table.allowsSelection = true
        return table
    }()
    
    let friendlyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FiraSans-Bold", size: 15)
        label.textColor = UIColor.collexapp.mainBlack
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()

}
