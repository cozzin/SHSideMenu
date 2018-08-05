//
//  SideMenuUsable.swift
//  SHSideMenu
//
//  Created by 홍성호 on 2018. 8. 6..
//  Copyright © 2018년 홍성호. All rights reserved.
//

import Foundation
import RxSwift

public enum SideMenuAction {
    case open
    case close
}

public protocol SideMenuUsable {
    var sideMenuAction: PublishSubject<SideMenuAction> { get }
}
