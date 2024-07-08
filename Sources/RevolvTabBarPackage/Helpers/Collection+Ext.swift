//
//  Collection+Ext.swift
//  RevolvTabBar
//
//  Created by Aykhan Hajiyev on 28.06.24.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        
        return self[index]
    }
}
