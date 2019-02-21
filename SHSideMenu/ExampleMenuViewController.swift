//
//  ExampleMenuViewController.swift
//  SHSideMenu
//
//  Created by 홍성호 on 2018. 8. 4..
//  Copyright © 2018년 홍성호. All rights reserved.
//

import UIKit
import RxSwift

class ExampleMenuViewController: UIViewController, ContentViewChangable {

    var items: [String] = ["bule", "green", "yello", "red", "present modal"]
    
    var viewTransition: BehaviorSubject<UIViewController> = BehaviorSubject<UIViewController>(value: UINavigationController(rootViewController: ExampleContentViewController(backgroundColor: .blue)))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reusableCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ExampleMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reusableCell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewTransition.onNext(UINavigationController(rootViewController: ExampleContentViewController(backgroundColor: .blue)))
        case 1:
            viewTransition.onNext(UINavigationController(rootViewController: ExampleContentViewController(backgroundColor: .green)))
        case 2:
            viewTransition.onNext(UINavigationController(rootViewController: ExampleContentViewController(backgroundColor: .yellow)))
        case 3:
            viewTransition.onNext(UINavigationController(rootViewController: ExampleContentViewController(backgroundColor: .red)))
        case 4:
            menuContainerViewController?.present(UINavigationController(rootViewController: ModalTestViewController()), animated: true)
            break
        default:
            break
        }
    }
}

class ModalTestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onTouchCloseButton(_:)))
    }
    
    @objc
    private func onTouchCloseButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
