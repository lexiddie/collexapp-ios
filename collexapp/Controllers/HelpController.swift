//
//  HelpController.swift
//  collexapp
//
//  Created by Lex on 15/8/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class HelpController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
    }

    private func initialView() {
        let view = HelpView(frame: self.view.frame)
        self.view = view
    }

}
