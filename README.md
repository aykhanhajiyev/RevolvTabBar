## Demo
![](https://github.com/aykhanhajiyev/RevolvTabBar/blob/master/Images/revolv-tab-bar-demo.gif)

## RevolvTabBar

RevolvTabBar is a customizable and easy-to-use tab bar controller for iOS applications. It allows you to quickly set up a tab bar with multiple view controllers, providing a seamless navigation experience.

## Installation

To integrate RevolvTabBar into your Xcode project using Swift Package Manager, add it to your Package.swift:

```bash
dependencies: [
    .package(url: "https://github.com/yourusername/RevolvTabBar.git", from: "1.0.3")
]
```

Then, add RevolvTabBar as a dependency to your target:

```bash
.target(
    name: "YourTargetName",
    dependencies: ["RevolvTabBar"]
)
```

## Usage

### Basic Setup

Here's an example of how to set up RevolvTabBar in your project:
```swift
import UIKit
import RevolvTabBar

class ViewController: RevolvTabBar {
    
    private let homeVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        return vc
    }()
    
    private let secondVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        return vc
    }()
    
    private let thirdVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemPink
        return vc
    }()
    
    override var items: RevolvTabBarView.Item {
        .defaultStyle
    }
    
    override var viewControllers: [UIViewController] {
        [homeVC, secondVC, thirdVC]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

### Explanation

1. Importing RevolvTabBar:
```bash
import RevolvTabBar
```
Ensure you import the RevolvTabBar package at the beginning of your file.

2. Creating View Controllers:
```swift
private let homeVC: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .white
    return vc
}()

private let secondVC: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .yellow
    return vc
}()

private let thirdVC: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .systemPink
    return vc
}()
```
Here, we create three view controllers (homeVC, secondVC, thirdVC) with different background colors which they are our tabBar controllers.

3. Setting Tab Bar Items:
   
```swift
override var items: RevolvTabBarView.Item {
    .defaultStyle
}
```
This property defines the style of the tab bar items. You can customize it according to your needs.

4. Assigning View Controllers:
   
```swift
override var viewControllers: [UIViewController] {
    [homeVC, secondVC, thirdVC]
}
```
This property returns an array of view controllers to be displayed in the tab bar.

5. viewDidLoad:
```swift
override func viewDidLoad() {
    super.viewDidLoad()
}
```
Ensure you call super.viewDidLoad() in your viewDidLoad method to properly initialize the tab bar.

6. tabBarBackgroundColor:
```swift
override var tabBarBackgroundColor: UIColor? {
    .red
}
```
It changes background color of tabBar view.

## License

RevolvTabBar is available under the MIT license. See the LICENSE file for more information
