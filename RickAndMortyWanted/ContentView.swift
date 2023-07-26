//
//  ContentView.swift
//  RickAndMortyWanted
//
//  Created by Iago on 26/06/23.
//

import SwiftUI

struct TabItem<Content: View> {
    var view: Content
}

enum TabTitle: String {
    case RECORDS = "Records"
    case WANTED = "Wanted"
    case LOCATIONS = "Locations"
}

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
    }
    
    @State var selection = 2
    
    private var navigationTitle: String {
        switch selection {
        case 0:
            return TabTitle.RECORDS.rawValue
        case 1:
            return TabTitle.WANTED.rawValue
        case 2:
            return TabTitle.LOCATIONS.rawValue
        default:
            return ""
        }
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                RecordsView()
                    .tabItem {
                        Label(TabTitle.RECORDS.rawValue, systemImage:"tv.inset.filled")
                    }.tag(1)
                WantedView()
                    .tabItem {
                        Label(TabTitle.WANTED.rawValue, systemImage:"person.fill") }
                    .tag(2)
                LocationsView()
                    .tabItem {
                        Label(TabTitle.LOCATIONS.rawValue, systemImage:"globe.americas.fill")}
                    .tag(3)
            }.environmentObject(Di.recordsViewModel)
                .environmentObject(Di.wantedViewModel)
                .environmentObject(Di.locationsViewModel)
        }
        .navigationTitle(navigationTitle)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
