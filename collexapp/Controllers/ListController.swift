//
//  ListController.swift
//  collexapp
//
//  Created by Lex on 15/8/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class ListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
    }

    private func initialView() {
        let view = ListView(frame: self.view.frame)
        self.view = view
    }

}
