//
//  UniversityController.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper

class UniversityController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var isSetupProfile: Bool = false
    var isChangeUniversity: Bool = false
    var isHome: Bool = false
    var previousController: UIViewController!
    let universityCell = "universityCell"
    var universities = [UniversityDto]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        table.allowsSelection = true
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        universities = Mapper<UniversityDto>().mapArray(JSONfile: "University.json")!
        universities = universities.sorted(by: {$0.name < $1.name})
        setupNavigationItems()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor.collexapp.mainLightWhite
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UniversityCell.self, forCellReuseIdentifier: universityCell)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return universities.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return universities[section].name
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.collexapp.mainDarkRed
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont(name: "FiraSans-Bold", size: 17)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities[section].campuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: universityCell, for: indexPath) as! UniversityCell
        cell.nameLabel.text = universities[indexPath.section].campuses[indexPath.row].name
        cell.selectionStyle = UITableViewCell.SelectionStyle.gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSetupProfile, let viewController = previousController as? SetupProfileController {
            viewController.university = universities[indexPath.section].getUniversity(index: indexPath.row)
            viewController.universityTextField.text = universities[indexPath.section].getCampus(index: indexPath.row)
        } else if isChangeUniversity, let viewController = previousController as? ChangeUniversityController {
            viewController.university = universities[indexPath.section].getUniversity(index: indexPath.row)
            viewController.universityTextField.text = universities[indexPath.section].getCampus(index: indexPath.row)
        } else if isHome, let viewController = previousController as? HomeController {
            viewController.universityButton.setTitle(universities[indexPath.section].getCampus(index: indexPath.row), for: .normal)
        }
        
        DispatchQueue.main.async {}
        self.dismiss(animated: true, completion: nil)
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
        titleLabel.text = "University"
        titleLabel.textColor = UIColor.collexapp.mainBlack
        titleLabel.font = UIFont(name: "FiraSans-Bold", size: 17)
        navigationItem.titleView = titleLabel
    }
    
    private func setupLeftNavItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ArrowLeft").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(UniversityController.handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.snp.makeConstraints{ (make) in
            make.height.width.equalTo(20)
        }
    }
}
