//
//  ContentView.swift
//  Shared
//
//  Created by Alan on 2021/1/19.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .calendar

    enum Tab {
        case myFlows, calendar, wiki
    }

    var body: some View {
        TabView(selection: $selection) {
            MyFlowsView()
                .tabItem {
                    Label("My Flows", systemImage: "rectangle.grid.2x2.fill")
                }
                .tag(Tab.myFlows)
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(Tab.calendar)
            WikiView()
                .tabItem {
                    Label("Wiki", systemImage: "globe")
                }
                .tag(Tab.wiki)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
