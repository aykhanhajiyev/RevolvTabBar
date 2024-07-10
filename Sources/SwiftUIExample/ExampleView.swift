//
//  ExampleView.swift
//  
//
//  Created by Alpay Calalli on 10.07.24.
//

import SwiftUI

@available(iOS 15.0, *)
struct ExampleView: View {
    @State private var selectedTabIndex = 0
    var body: some View {
        RevolvTabView(selection: $selectedTabIndex) {
            TabItem(iconName: "house") {
                ExampleView1()
            }
            
            TabItem(iconName: "gear") {
                ExampleView2()
            }
            
            TabItem(iconName: "person") {
                ExampleView3()
            }
        }
        .task(id: selectedTabIndex) { }
    }
}

@available(iOS 15.0, *)
#Preview {
    ExampleView()
}

@available(iOS 15.0, *)
struct ExampleView1: View {
    init() {
        print("ExampleView1 - init")
    }
    var body: some View {
        VStack {
            ForEach(0..<30) {
                Text($0.formatted())
            }
        }
        .task {
            print("ExampleView 1 - task")
        }
    }
}

@available(iOS 15.0, *)
struct ExampleView2: View {
    init() {
        print("ExampleView2 - init")
    }
    var body: some View {
        Color.green
            .ignoresSafeArea()
            .task {
                print("ExampleView 2 - task")
            }
    }
}

@available(iOS 15.0, *)
struct ExampleView3: View {
    init() {
        print("ExampleView3 - init")
    }
    var body: some View {
        NavigationView {
            VStack {
                ForEach(0..<20) {
                    Text($0.formatted())
                }
            }
            .navigationTitle("Title")
            .task {
                print("ExampleView 3 - task")
            }
        }
    }
}
