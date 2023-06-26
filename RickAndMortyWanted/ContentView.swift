//
//  ContentView.swift
//  RickAndMortyWanted
//
//  Created by Iago on 26/06/23.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                RecordsView()
                    .tabItem {
                        Label("Records", systemImage:"tv.inset.filled")
                    }
                WantedView()
                    .tabItem {
                        Label("Wanted", systemImage:"person.fill")
                    }
                LocationsView()
                    .tabItem {
                        Label("Locations", systemImage:"globe.americas.fill")
                    }.tag(1)
            }
            .navigationTitle(selection == 1 ? "First" : "Second") // << here !!
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LocationsView: View {
    var body: some View {
        Text("Locations")
            .font(.title)
    }
}

struct WantedView: View {
    var body: some View {
        Text("Wanted")
            .font(.title)
    }
}

struct RecordsView: View {
    var body: some View {
        Text("Records")
            .font(.title)
    }
}
