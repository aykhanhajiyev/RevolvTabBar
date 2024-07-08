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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 28
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
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,  constant: 28),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

extension RevolvTabBarView: ConfigurableView {
    public struct Item {
        let items: [RevolvTabBarItemView.Item]
        let tintColor: UIColor?
        let selectedTintColor: UIColor?
        
        init(items: [RevolvTabBarItemView.Item], tintColor: UIColor, selectedTintColor: UIColor) {
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
    
    func configure(_ item: Item) {
        item.items.enumerated().forEach { (index, subItem) in
            let subview = RevolvTabBarItemView()
            subview.configure(subItem)
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
