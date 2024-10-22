//
//  ConfigurableView.swift
//  RevolvTabBar
//
//  Created by Aykhan Hajiyev on 28.06.24.
//

import Foundation

internal protocol ConfigurableView {
    associatedtype Item
    
    func configure(_ item: Item)
}
