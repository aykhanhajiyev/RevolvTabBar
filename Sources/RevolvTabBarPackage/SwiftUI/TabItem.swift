//
//  TabItem.swift
//  
//
//  Created by Alpay Calalli on 10.07.24.
//

import SwiftUI

@available(iOS 15.0, *)
@resultBuilder
struct TabItemBuilder {
    static func buildBlock(_ components: TabItem...) -> [TabItem] {
        components
    }
}

@available(iOS 15.0, *)
struct TabItem: Identifiable {
    let id = UUID()
    let iconName: String
    let content: AnyView
    
    init<Content: View>(
        iconName: String,
        @ViewBuilder content: () -> Content
    ) {
        self.iconName = iconName
        self.content = AnyView(content())
    }
}

@available(iOS 15.0, *)
extension TabItem: Equatable {
    static func == (lhs: TabItem, rhs: TabItem) -> Bool {
        lhs.id == rhs.id
    }
}
