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
    }
}

extension RevolvTabBarItemView: ConfigurableView {
    struct Item {
        let icon: UIImage?
    }
    
    func configure(_ item: Item) {
        iconButton.setImage(item.icon, for: .normal)
    }
}
