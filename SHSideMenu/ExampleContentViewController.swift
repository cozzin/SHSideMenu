//
//  ExampleContentViewController.swift
//  SHSideMenu
//
//  Created by 홍성호 on 2018. 8. 6..
//  Copyright © 2018년 홍성호. All rights reserved.
//

import UIKit
import RxSwift

class ExampleContentViewController: UIViewController, SideMenuUsable {
    
    var sideMenuAction: PublishSubject<SideMenuAction> = PublishSubject<SideMenuAction>()

    private var backgroundColor: UIColor
    
    init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit: \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColor
        title = "\(backgroundColor)"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(onSideMenuButtonTouch(_:)))
    }
    
    @objc private func onSideMenuButtonTouch(_ sender: UIButton) {
        sideMenuAction.onNext(.open)
    }
}
