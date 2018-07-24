//
//  ViewController.swift
//  SHSideMenu
//
//  Created by 홍성호 on 2018. 7. 25..
//  Copyright © 2018년 홍성호. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var sideMenuViewController: SideMenuViewController = {
        let sideMenuViewController = SideMenuViewController()
        let tableView = UITableView()
        sideMenuViewController.contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return sideMenuViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(onSideMenuButtonTouch(_:)))
    }
    
    @objc func onSideMenuButtonTouch(_ sender: UIButton) {
        navigationController?.present(sideMenuViewController, animated: false)
    }
}

