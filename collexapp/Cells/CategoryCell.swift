//
//  CategoryCell.swift
//  collexapp
//
//  Created by Lex on 7/9/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        label.layer.backgroundColor = UIColor.clear.cgColor
        label.layer.borderColor = UIColor.collexapp.mainGrey.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 5
        label.font = UIFont(name: "FiraSans-Bold", size: 15)
        label.textAlignment = .center
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.numberOfLines = 1
        label.padding(0, 10, 0, 10)
        return label
    }()
}
