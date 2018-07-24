//
//  UIViewController+Extension.swift
//  SHSideMenu
//
//  Created by 홍성호 on 2018. 7. 25..
//  Copyright © 2018년 홍성호. All rights reserved.
//

import UIKit

extension UIViewController {
    func animateLayout(duration: TimeInterval = 0.3, animations: (() -> Void)? = nil, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.view.layoutIfNeeded()
            animations?()
            }, completion: { isFinished in
                completion?(isFinished)
        })
    }
}
