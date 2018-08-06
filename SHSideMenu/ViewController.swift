//
//  ViewController.swift
//  SHSideMenu
//
//  Created by 홍성호 on 2018. 8. 4..
//  Copyright © 2018년 홍성호. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("show", for: .normal)
        button.addTarget(self, action: #selector(onTouchButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var sideMenuViewController: SideMenuViewController = {
        let sideMenuViewController = SideMenuViewController(left: ExampleMenuViewController())
        return sideMenuViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func onTouchButton() {
        present(sideMenuViewController, animated: true)
    }
}
