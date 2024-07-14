//
//  RevolvTabBar.swift
//  RevolvTabBar
//
//  Created by Aykhan Hajiyev on 23.06.24.
//

import UIKit

open class RevolvTabBar: UIViewController {
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot to override viewControllers || viewControllers list is empty."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let tabBarView: RevolvTabBarView = {
        let tabBarView = RevolvTabBarView()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        return tabBarView
    }()
    
    /// TabBar viewControllers holder
    open var viewControllers: [UIViewController] {
        []
    }
    
    /// TabBar items
    open var items: RevolvTabBarView.Item {
        .defaultStyle
    }
    
    /// TabBar background color
    open var tabBarBackgroundColor: UIColor? {
        nil
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        view.addSubview(tabBarView)
        configureConstraints()
        setup()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let firstVC = viewControllers.first {
            addChild(firstVC)
            contentView.addSubview(firstVC.view)
            firstVC.didMove(toParent: self)
        } else {
            view.addSubview(infoLabel)
            NSLayoutConstraint.activate([
                infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
        }
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBarView.addShadow()
    }
}

private extension UIView {
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.24
        layer.shadowOffset = .zero
        layer.shadowRadius = 15
    }
}

private extension RevolvTabBar {
    func configureConstraints() {
        configureContentView()
        configureTabBarView()
        
        // Inner functions
        func configureContentView() {
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        
        func configureTabBarView() {
            NSLayoutConstraint.activate([
                tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tabBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
    
    func setup() {
        tabBarView.configure(items)
        tabBarView.delegate = self
        tabBarView.backgroundColor = tabBarBackgroundColor
    }
}

extension RevolvTabBar: RevolvTabBarViewProtocol {
    func didTapItem(_ item: RevolvTabBarItemView, tapIndex: Int) {
        if let tappedIndexVC = viewControllers[safe: tapIndex] {
            addChild(tappedIndexVC)
            contentView.addSubview(tappedIndexVC.view)
            tappedIndexVC.didMove(toParent: self)
        }
    }
}
