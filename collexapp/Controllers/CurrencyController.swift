//
//  CurrencyController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper

class CurrencyController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var isSetupProfile: Bool = false
    var isChangeCurrency: Bool = false
    var previousController: UIViewController!
    let currencyCell = "currencyCell"
    var currencies = [Currency]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        table.allowsSelection = true
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        currencies = Mapper<Currency>().mapArray(JSONfile: "Currencies.json")!
        setupNavigationItems()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupTableView() {
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: currencyCell)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyCell, for: indexPath) as! CurrencyCell
        cell.nameLabel.text = "\(currencies[indexPath.item].code!) - \(currencies[indexPath.item].name!)"
        cell.selectionStyle = UITableViewCell.SelectionStyle.gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSetupProfile, let viewController = previousController as? SetupProfileController {
            viewController.currency = currencies[indexPath.row]
            viewController.currencyTextField.text = "\(currencies[indexPath.item].code!) - \(currencies[indexPath.item].name!)"
        } else if isChangeCurrency, let viewController = previousController as? ChangeCurrencyController {
            viewController.currency = currencies[indexPath.row]
            viewController.currencyTextField.text = "\(currencies[indexPath.item].code!) - \(currencies[indexPath.item].name!)"
        }
        DispatchQueue.main.async {}
        self.dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Currencies"
    }
    
    @IBAction func handleDismiss(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupNavigationItems() {
        setupTitleNavItem()
        setupLeftNavItem()
    }
    
    private func setupTitleNavItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Select Currency"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    private func setupLeftNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ArrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(CurrencyController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
}
