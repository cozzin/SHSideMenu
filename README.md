# SHSideMenu
Simple side menu view controller 🍔
    
At a Glance
-----------

```swift
import SHSideMenu

let sideMenuViewController = SideMenuViewController(left: ExampleMenuViewController())

class ExampleMenuViewController: UIViewController, ContentViewChangable {
    viewTransition.onNext(UIViewController())
}

class ExampleContentViewController: UIViewController, SideMenuUsable {
    sideMenuAction.onNext(.open)
}
```

Installation
------------

- **For iOS 10+ projects with [CocoaPods](https://cocoapods.org):**

```ruby
pod 'SHSideMenu', '~> 0.0.5'
```


Getting Started
-----------
```swift
// 1. Create SideMenuViewController
let sideMenuViewController = SideMenuViewController(left: ExampleMenuViewController())


// 2. ContentViewChangable
class ExampleMenuViewController: UIViewController, ContentViewChangable {

   var viewTransition: BehaviorSubject<UIViewController> = BehaviorSubject<UIViewController>(value: UINavigationController(rootViewController: ExampleContentViewController(backgroundColor: .blue))) // set first view controller

   func change(row: Int) {
        switch row {
        case 0:
            viewTransition.onNext(UINavigationController(rootViewController: ExampleContentViewController(backgroundColor: .blue)))
        case 1:
            viewTransition.onNext(UINavigationController(rootViewController: ExampleContentViewController(backgroundColor: .green)))
        case 2:
            viewTransition.onNext(UINavigationController(rootViewController: ExampleContentViewController(backgroundColor: .yellow)))
        case 3:
            viewTransition.onNext(UINavigationController(rootViewController: ExampleContentViewController(backgroundColor: .red)))
        default:
            break
        }
   }
}


// 3. SideMenuUsable
class ExampleContentViewController: UIViewController, SideMenuUsable {
    
    var sideMenuAction: PublishSubject<SideMenuAction> = PublishSubject<SideMenuAction>()

    func open() {
        sideMenuAction.onNext(.open)
    }

    func close() {
        sideMenuAction.onNext(.close)
    }
}
```

Screenshots
-----------

<img src="https://user-images.githubusercontent.com/11647461/43154093-1fb6a3e0-8fae-11e8-9fd7-eb3fdb96f4ae.png" width="300">
