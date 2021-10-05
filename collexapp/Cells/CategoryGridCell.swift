//
//  CategoryGridCell.swift
//  collexapp
//
//  Created by Lex on 19/8/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class CategoryGridCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.centerX.centerY.equalTo(self)
            make.left.right.lessThanOrEqualTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = PaddingLabel()
        label.textColor = UIColor.collexapp.mainBlack
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.borderColor = UIColor.collexapp.mainDarkGrey.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 5
        label.font = UIFont(name: "FiraSans-Bold", size: 17)
        label.textAlignment = .center
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.numberOfLines = 1
        label.padding(0, 10, 0, 10)
        return label
    }()

}
