//
//  MenuConatinerViewController.swift
//  SHSideMenu
//
//  Created by 홍성호 on 2018. 6. 26..
//  Copyright © 2018년 홍성호. All rights reserved.
//

import UIKit
import SnapKit

class MenuContainerViewController: UIViewController {
    
    private lazy var didUpdateViewConstraints: Bool = false
    private var trailingConstraint: Constraint?
    private var widthRatio: CGFloat
    private var trailingMaxOffset: CGFloat {
        return view.frame.width * widthRatio
    }
    private var rootViewController: UIViewController
    
    // MARK: - SubViews
    
    private(set) public var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    }()
    
    private var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.backgroundColor = .black
        closeButton.addTarget(self, action: #selector(onCloseButton(_:)), for: .touchUpInside)
        closeButton.alpha = 0.0
        return closeButton
    }()
    
    // MARK: - Life Cycle
    
    public init(rootViewController: UIViewController, widthRatio: CGFloat = 0.6) {
        self.rootViewController = rootViewController
        self.widthRatio = widthRatio
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.isOpaque = false
        
        view.addSubview(contentView)
        view.addSubview(closeButton)
        
        contentView.addSubview(rootViewController.view)
        
        rootViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            self.trailingConstraint = make.trailing.equalTo(view.snp.leading).constraint
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(contentView.snp.trailing)
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        open()
    }
    
    // MARK: - Action
    
    @objc func onCloseButton(_ sender: UIButton) {
        close()
    }
    
    public func open(completion: (() -> Void)? = nil) {
        trailingConstraint?.update(offset: trailingMaxOffset)
        animateLayout(animations: { [weak self] in
            self?.closeButton.alpha = 0.5
        }) { isFinished in
            if isFinished {
                completion?()
            }
        }
    }
    
    public func close(completion: (() -> Void)? = nil) {
        trailingConstraint?.update(offset: 0)
        animateLayout(animations: { [weak self] in
            self?.closeButton.alpha = 0.0
        }) { [weak self] isFinished in
            if isFinished {
                self?.dismiss(animated: false)
                completion?()
            }
        }
    }
}
