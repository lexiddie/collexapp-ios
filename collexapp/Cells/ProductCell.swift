//
//  ProductCell.swift
//  collexapp
//
//  Created by Lex on 19/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import SnapKit

class ProductCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellView)
        setupCellView()
        cellView.addSubview(productImageView)
        setupProductImageView()
        cellView.addSubview(sellerInformationView)
        setupSellerInformationView()
        sellerInformationView.addSubview(sellerProfileImageView)
        setupSellerProfileImageView()
        sellerInformationView.addSubview(informationStackView)
        setupInformationStackView()
        informationStackView.addArrangedSubview(productNameLabel)
        informationStackView.addArrangedSubview(productPriceLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    private func setupCellView() {
        cellView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self).inset(5)
            make.left.right.equalTo(self).inset(8)
        }
    }
     
    var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.collexapp.mainLightGrey.cgColor
        imageView.backgroundColor = UIColor.collexapp.mainLightWhite
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private func setupProductImageView() {
        productImageView.snp.makeConstraints { (make) in
            make.top.equalTo(cellView)
            make.left.right.lessThanOrEqualTo(cellView).inset(10)
            make.centerX.equalTo(cellView)
            make.height.equalTo(200)
        }
    }
    
    let sellerInformationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private func setupSellerInformationView() {
        sellerInformationView.snp.makeConstraints { (make) in
            make.top.equalTo(productImageView.snp.bottom).offset(5)
            make.left.right.equalTo(cellView)
            make.bottom.equalTo(cellView).inset(10)
            make.height.equalTo(50)
        }
    }
    
    let sellerProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ProfileImage").withRenderingMode(.alwaysOriginal)
        imageView.layer.cornerRadius = 40/2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func setupSellerProfileImageView() {
        sellerProfileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(sellerInformationView)
            make.height.width.equalTo(40)
            make.left.lessThanOrEqualTo(sellerInformationView).inset(10)
        }
    }
    
    let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.leading
        stackView.distribution = UIStackView.Distribution.fillEqually
        return stackView
    }()
    
    private func setupInformationStackView() {
        informationStackView.snp.makeConstraints { (make) in
            make.centerY.equalTo(sellerInformationView)
            make.height.equalTo(40)
            make.width.equalTo(self.frame.width - 70)
            make.left.lessThanOrEqualTo(sellerProfileImageView.snp.right).offset(10)
            make.right.lessThanOrEqualTo(sellerInformationView).inset(10)
        }
    }
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Bold", size: 17)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    
    let productPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.collexapp.mainBlack
        label.font = UIFont(name: "FiraSans-Regular", size: 17)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
}
