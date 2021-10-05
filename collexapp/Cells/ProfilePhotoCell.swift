//
//  ProfilePhotoCell.swift
//  collexapp
//
//  Created by Lex on 20/8/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class ProfilePhotoCell: UICollectionViewCell {
    
    var product: ListProduct? {
        didSet {
            guard let profileImageUrl = product?.sellerImageUrl else { return }
            if profileImageUrl != "" {
                profileImageView.af.setImage(withURL: URL(string: profileImageUrl)!)
            } else {
                profileImageView.image = #imageLiteral(resourceName: "ProfileImage").withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ProfileImage").withRenderingMode(.alwaysOriginal)
        imageView.layer.cornerRadius = 80/2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
