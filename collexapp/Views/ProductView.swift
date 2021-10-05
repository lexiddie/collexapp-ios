//
//  ProductView.swift
//  collexapp
//
//  Created by Lex on 19/8/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class ProductView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
    }

}
