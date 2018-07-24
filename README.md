# SHSideMenu
Simple side menu view controller 🍔
    
At a Glance
-----------

```swift
import SHSideMenu

navigationController?.present(SideMenuViewController(), animated: false)
```

Installation
------------

- **For iOS 10+ projects with [CocoaPods](https://cocoapods.org):**

```ruby
pod 'SHSideMenu', '~> 0.0.3'
```


Getting Started
-----------
```swift
// Configuration
let sideMenuViewController = SideMenuViewController()
let tableView = UITableView()
sideMenuViewController.contentView.addSubview(tableView)
tableView.snp.makeConstraints { make in
    make.edges.equalToSuperview()
}

// show
navigationController?.present(sideMenuViewController, animated: false)
```

Screenshots
-----------

<img src="https://user-images.githubusercontent.com/11647461/43154093-1fb6a3e0-8fae-11e8-9fd7-eb3fdb96f4ae.png" width="300">
