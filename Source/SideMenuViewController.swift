//
//  SideMenuViewController.swift
//  SHSideMenu
//
//  Created by 홍성호 on 2018. 7. 25..
//  Copyright © 2018년 홍성호. All rights reserved.
//

import UIKit
import RxSwift

public class SideMenuViewController: UINavigationController {
    
    private let disposeBag: DisposeBag = DisposeBag()
    private var leftViewController: UIViewController
    private var firstViewController: UIViewController

    private lazy var menuContainerViewController: MenuContainerViewController = {
        let menuContainerViewController = MenuContainerViewController(rootViewController: leftViewController)
        return menuContainerViewController
    }()
    
    // MARK: - Life Cycle
    
    init(left leftViewController: UIViewController, first firstViewController: UIViewController) {
        self.leftViewController = leftViewController
        self.firstViewController = firstViewController
        super.init(nibName: nil, bundle: nil)
        
        changeRootViewController(firstViewController)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        bind()
    }
    
    private func bind() {
        if let leftViewController = leftViewController as? ContentViewChangable {
            leftViewController.viewTransition.asObserver().subscribe(onNext: { [weak self] in
                
                switch $0 {
                case .change(let viewController):
                    self?.menuContainerViewController.close()
                    self?.changeRootViewController(viewController)
                }
            }).disposed(by: disposeBag)
        }
    }
    
    private func changeRootViewController(_ viewController: UIViewController) {
        setViewControllers([viewController], animated: false)
        if let sideMenuUsable = viewController as? SideMenuUsable {
            sideMenuUsable.sideMenuAction.asObserver().subscribe(onNext: { [weak self] action in
                switch action {
                case .open:
                    self?.openMenuViewController()
                case .close:
                    self?.menuContainerViewController.close()
                }
            }).disposed(by: disposeBag)
        }
    }
    
    private func openMenuViewController() {
        present(menuContainerViewController, animated: false)
    }
}
