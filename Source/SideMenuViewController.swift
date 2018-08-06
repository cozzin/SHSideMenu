//
//  SideMenuViewController.swift
//  SHSideMenu
//
//  Created by 홍성호 on 2018. 7. 25..
//  Copyright © 2018년 홍성호. All rights reserved.
//

import UIKit
import RxSwift

open class SideMenuViewController: UIViewController {
    
    private let disposeBag: DisposeBag = DisposeBag()
    private var leftViewController: UIViewController

    private lazy var menuContainerViewController: MenuContainerViewController = {
        let menuContainerViewController = MenuContainerViewController(rootViewController: leftViewController)
        return menuContainerViewController
    }()
    
    // MARK: - Life Cycle
    
    public init(left leftViewController: UIViewController) {
        self.leftViewController = leftViewController
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        if let leftViewController = leftViewController as? ContentViewChangable {
            leftViewController.viewTransition.asObserver().subscribe(onNext: { [weak self] in
                self?.menuContainerViewController.close()
                self?.changeContentViewController($0)
            }).disposed(by: disposeBag)
        }
    }
    
    private func changeContentViewController(_ viewController: UIViewController) {
        childViewControllers.forEach {
            $0.removeFromParentViewController()
        }
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        bindSideMenuUsable(viewController)
    }
    
    private func bindSideMenuUsable(_ viewController: UIViewController) {
        if let sideMenuUsableViewController = viewController as? SideMenuUsable {
            sideMenuUsableViewController.sideMenuAction.asObserver().subscribe(onNext: { [weak self] action in
                switch action {
                case .open:
                    self?.openMenuViewController()
                case .close:
                    self?.menuContainerViewController.close()
                }
            }).disposed(by: disposeBag)
        } else {
            viewController.childViewControllers.forEach {
                bindSideMenuUsable($0)
            }
        }
    }
    
    private func openMenuViewController() {
        present(menuContainerViewController, animated: false)
    }
}
