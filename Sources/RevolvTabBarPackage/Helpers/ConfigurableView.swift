//
//  ConfigurableView.swift
//  RevolvTabBar
//
//  Created by Aykhan Hajiyev on 28.06.24.
//

import UIKit

internal protocol ConfigurableView {
    associatedtype Item
    
    func configure(_ item: Item)
    func configure(_ item: Item, iconSize: CGFloat)
    func configure(_ item: Item, spacing: CGFloat, iconSize: CGFloat, contentInsets: UIEdgeInsets)
}

extension ConfigurableView {
    func configure(_ item: Item) { }
    func configure(_ item: Item, iconSize: CGFloat) { }
    func configure(_ item: Item, spacing: CGFloat, iconSize: CGFloat, contentInsets: UIEdgeInsets) { }
}
