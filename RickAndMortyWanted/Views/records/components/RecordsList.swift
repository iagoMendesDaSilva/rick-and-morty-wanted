//
//  RecordsList.swift
//  RickAndMortyWanted
//
//  Created by Iago on 22/07/23.
//

import SwiftUI

extension Color {
    func brightness() -> Double {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, opacity: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &opacity)
        return (0.299 * Double(red) + 0.587 * Double(green) + 0.114 * Double(blue))
    }
}

struct RecordsList: View {
    var viewModel: RecordsViewModel
    var isFiltered: Bool
    var onRefresh: () -> Void
    
    @State private var gradients: [Int: LinearGradient] = [:]
    
    init(viewModel: RecordsViewModel,isFiltered: Bool, onRefresh: @escaping ()->Void) {
        self.viewModel = viewModel
        self.isFiltered = isFiltered
        self.onRefresh = onRefresh
    }
    
    func randomColor() -> Color {
        var randomColor: Color
        repeat {
            let red = Double.random(in: 0...1)
            let green = Double.random(in: 0...1)
            let blue = Double.random(in: 0...1)
            randomColor = Color(red: red, green: green, blue: blue)
        } while randomColor.brightness() > 0.8
        
        return randomColor
    }
    
    
    func createGradient(for season: Int) -> LinearGradient {
        if let gradient = gradients[season] {
            return gradient
        } else {
            let primaryColor = self.randomColor()
            let darkColor = primaryColor.opacity(0.5)
            let gradient = LinearGradient(gradient: Gradient(colors: [primaryColor, darkColor]), startPoint: .leading, endPoint: .trailing)
            gradients[season] = gradient
            return gradient
        }
    }
    
    func verifyEndList(for item: Season) {
        if viewModel.records.last?.id == item.id {
            viewModel.getRecords(loadMore: true)
        }
    }
    
    var body: some View {
        List ( isFiltered ? viewModel.recordsFiltered : viewModel.records, id: \.id) { item in
            Section(header: SectionHeader(season: item.id)) {
                ZStack(alignment: .bottomTrailing){
                ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            if(!viewModel.records.isEmpty){
                                let index = viewModel.records.count <= 1 ? 0: item.id-1
                                ForEach(viewModel.records[index].episodes, id: \.id) { episode in
                                    RecordsListItem(record: episode, gradient: createGradient(for: item.id))
                                }
                            }
                        }.frame( height: 150)
                            .onAppear(){
                                verifyEndList(for: item)
                            }
                    }
                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBackground), .clear]), startPoint: .trailing, endPoint: .leading)).frame(width: 75, height: .infinity)
                }
            }.listRowSeparator(.hidden)
        }.listStyle(.plain)
            .refreshable {
                onRefresh()
                verifyEndList(for: viewModel.records.last!)
            }
    }
}
