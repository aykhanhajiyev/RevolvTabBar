//
//  RevolvTabBarItemView.swift
//  RevolvTabBar
//
//  Created by Aykhan Hajiyev on 26.06.24.
//

import UIKit

internal protocol RevolvTabBarItemViewDelegate: AnyObject {
    func didTapIconButton(_ item: RevolvTabBarItemView)
}

public final class RevolvTabBarItemView: UIView {
    
    weak var delegate: RevolvTabBarItemViewDelegate? = nil
    
    internal var isSelected: Bool = false {
        didSet {
            changeTabButtonState()
        }
    }
    
    internal var selectedTintColor: UIColor? = nil
    
    internal var customTintColor: UIColor? = nil
    
    private var item: RevolvTabBarItemView.Item? = nil
    
    private let iconButton: UIButton = {
        let iconButton = UIButton(type: .system)
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        iconButton.imageView?.contentMode = .scaleAspectFit
        return iconButton
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RevolvTabBarItemView {
    func setupUI() {
        addSubview(iconButton)
        iconButton.addTarget(self, action: #selector(didTapIconButton), for: .touchUpInside)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            iconButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconButton.topAnchor.constraint(equalTo: topAnchor),
            iconButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconButton.heightAnchor.constraint(equalToConstant: 24),
            iconButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc 
    func didTapIconButton() {
        delegate?.didTapIconButton(self)
    }
    
    func changeTabButtonState() {
        iconButton.tintColor = isSelected ? selectedTintColor : customTintColor
        
        if let selectedIcon = item?.selectedIcon {
            iconButton.setImage(isSelected ? selectedIcon : item?.icon, for: .normal)
        }
    }
}

extension RevolvTabBarItemView: ConfigurableView {
    public struct Item {
        let icon: UIImage?
        let selectedIcon: UIImage?
        
        public init(icon: UIImage?, selectedIcon: UIImage? = nil) {
            self.icon = icon
            self.selectedIcon = selectedIcon
        }
    }
    
    func configure(_ item: Item) {
        self.item = item
        
        let icon = isSelected ? item.selectedIcon : item.icon
        iconButton.setImage(icon, for: .normal)
    }
}
