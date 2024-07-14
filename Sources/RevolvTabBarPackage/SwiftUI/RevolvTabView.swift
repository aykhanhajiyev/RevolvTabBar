//
//  RevolvTabView.swift
//
//
//  Created by Alpay Calalli on 10.07.24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct RevolvTabView: View {
    @Binding private var externalSelectedTabIndex: Int
    @State private var internalSelectedTabIndex: Int
    private let tabs: [TabItem]
    private let useExternalBinding: Bool
    
    /// Initializes a RevolvTabView with selection binding.
    ///
    /// Use this initializer when you want to control or observe the selected tab index from outside the view.
    ///
    /// - Parameters:
    ///   - selection: A binding to the selected tab index. This allows external control and observation of the selected tab.
    ///   - content: A closure that returns an array of TabItems. Use the TabItemBuilder syntax to define the tabs.
    ///
    /// - Example:
    ///   ```
    ///   @State var selectedTab = 0
    ///   RevolvTabView(selection: $selectedTab) {
    ///       TabItem(iconName: "house") { Text("Home") }
    ///       TabItem(iconName: "gear") { Text("Settings") }
    ///   }
    ///   ```
    init(selection: Binding<Int>, @TabItemBuilder content: () -> [TabItem]) {
        self._externalSelectedTabIndex = selection
        self._internalSelectedTabIndex = State(initialValue: 0)
        self.tabs = content()
        self.useExternalBinding = true
    }
    
    /// Initializes a RevolvTabView.
    ///
    /// Use this initializer when you don't need to control or observe the selected tab index from outside the view.
    /// The view will manage its selected tab state internally.
    ///
    /// - Parameter content: A closure that returns an array of TabItems. Use the TabItemBuilder syntax to define the tabs.
    ///
    /// - Example:
    ///   ```
    ///   RevolvTabView {
    ///       TabItem(iconName: "house") { Text("Home") }
    ///       TabItem(iconName: "gear") { Text("Settings") }
    ///   }
    ///   ```
    init(@TabItemBuilder content: () -> [TabItem]) {
        self._externalSelectedTabIndex = .constant(0)
        self._internalSelectedTabIndex = State(initialValue: 0)
        self.tabs = content()
        self.useExternalBinding = false
    }
    
    private var selectedTabIndex: Int {
        useExternalBinding ? externalSelectedTabIndex : internalSelectedTabIndex
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            tabs[selectedTabIndex].content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
               
            tabContainerView
        }
    }
}

@available(iOS 15.0, *)
extension RevolvTabView {
    private var tabContainerView: some View {
        HStack(spacing: 10) {
            ForEach(Array(tabs.enumerated()), id: \.element.id) { index, tab in
                Button(action: {
                    if useExternalBinding {
                        externalSelectedTabIndex = index
                    } else {
                        internalSelectedTabIndex = index
                    }
                }) {
                    Image(systemName: tab.iconName)
                        .foregroundColor(selectedTabIndex == index ? .blue : .gray)
                        .font(.title3)
                        .padding(5)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.white)
        .clipShape(.capsule(style: .circular))
        .shadow(radius: 5)
    }
}
