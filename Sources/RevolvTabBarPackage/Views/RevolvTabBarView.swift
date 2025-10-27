//
//  RevolvTabBarView.swift
//  RevolvTabBar
//
//  Created by Aykhan Hajiyev on 23.06.24.
//

import UIKit

internal protocol RevolvTabBarViewProtocol: AnyObject {
    func didTapItem(_ item: RevolvTabBarItemView, tapIndex: Int)
}

public final class RevolvTabBarView: UIView {
    
    weak var delegate: RevolvTabBarViewProtocol? = nil
    
    private var leadingConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}

private extension RevolvTabBarView {
    func setupUI() {
        backgroundColor = .white
        addSubview(stackView)
    }
    
    func configureConstraints() {
        leadingConstraint = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        trailingConstraint = stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        bottomConstraint = stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            leadingConstraint!,
            topConstraint!,
            trailingConstraint!,
            bottomConstraint!
        ])
    }
    
    func updateContentInsets(_ insets: UIEdgeInsets) {
        leadingConstraint?.constant = insets.left
        topConstraint?.constant = insets.top
        trailingConstraint?.constant = -insets.right
        bottomConstraint?.constant = -insets.bottom
    }
}

extension RevolvTabBarView: ConfigurableView {
    public struct Item {
        let items: [RevolvTabBarItemView.Item]
        let tintColor: UIColor?
        let selectedTintColor: UIColor?
        
        public init(items: [RevolvTabBarItemView.Item], tintColor: UIColor, selectedTintColor: UIColor) {
            self.items = items
            self.tintColor = tintColor
            self.selectedTintColor = selectedTintColor
        }
        
        static var defaultStyle: Item = .init(
            items: [
                .init(icon: UIImage(named: "home-smile")),
                .init(icon: UIImage(named: "compass-03")),
                .init(icon: UIImage(named: "grid-01"))
            ],
            tintColor: .gray,
            selectedTintColor: .blue
        )
    }
    
    func configure(_ item: Item, spacing: CGFloat = 20, iconSize: CGFloat = 40, contentInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)) {
        stackView.spacing = spacing
        updateContentInsets(contentInsets)
        item.items.enumerated().forEach { (index, subItem) in
            let subview = RevolvTabBarItemView()
            subview.configure(subItem, iconSize: iconSize)
            subview.delegate = self
            subview.selectedTintColor = item.selectedTintColor
            subview.customTintColor = item.tintColor
            subview.isSelected = index == 0
            stackView.addArrangedSubview(subview)
        }
    }
}

// MARK: - RevolvTabBarItemViewDelegate
extension RevolvTabBarView: RevolvTabBarItemViewDelegate {
    func didTapIconButton(_ item: RevolvTabBarItemView) {
        stackView.arrangedSubviews.enumerated().forEach { (index, subview) in
            (subview as? RevolvTabBarItemView)?.isSelected = false
            if subview == item {
                delegate?.didTapItem(item, tapIndex: index)
            }
        }
        item.isSelected = true
    }
}
