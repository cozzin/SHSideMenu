//
//  SideMenuViewController.swift
//  SHSideMenu
//
//  Created by 홍성호 on 2018. 7. 25..
//  Copyright © 2018년 홍성호. All rights reserved.
//

import UIKit
import RxSwift

public class SideMenuViewController: UIViewController {
    
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
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(firstViewController.view)
        firstViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(onSideMenuButtonTouch(_:)))
        
        bind()
    }
    
    private func bind() {
        if let leftViewController = leftViewController as? SideMenuUsable {
            leftViewController.viewTransition.asObserver().subscribe(onNext: { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                
                switch $0 {
                case .change(let viewController):
                    strongSelf.view.subviews.forEach {
                        $0.snp.removeConstraints()
                        $0.removeFromSuperview()
                    }
                    
                    strongSelf.view.addSubview(viewController.view)
                    viewController.view.snp.makeConstraints { make in
                        make.edges.equalToSuperview()
                    }
                    strongSelf.menuContainerViewController.close()
                }
            }).disposed(by: disposeBag)
        }
    }
    
    @objc private func onSideMenuButtonTouch(_ sender: UIButton) {
        present(menuContainerViewController, animated: false)
    }
}
