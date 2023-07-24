//
//  RecordsList.swift
//  RickAndMortyWanted
//
//  Created by Iago on 22/07/23.
//

import SwiftUI

struct RecordsList: View {
    var viewModel: RecordsViewModel
    var isFiltered: Bool
    var onRefresh: () -> Void
    
    init(viewModel: RecordsViewModel,isFiltered: Bool, onRefresh: @escaping ()->Void) {
        self.viewModel = viewModel
        self.isFiltered = isFiltered
        self.onRefresh = onRefresh
    }
    
    func verifyEndList(for item: Season) {
        if viewModel.records.last?.id == item.id {
            viewModel.getRecords(loadMore: true)
        }
    }
    
    var body: some View {
        let records = isFiltered ? viewModel.recordsFiltered : viewModel.records
        List(records.indices, id: \.self) { index in
            Section(header: RecordSectionHeader(season: records[index].id)) {
                ZStack(alignment: .bottomTrailing){
                ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            if(!viewModel.records.isEmpty){
                                ForEach(records[index].episodes, id: \.id) { episode in
                                    RecordsListItem(record: episode, gradient: ColorService.gradients[index])
                                }
                            }
                        }.frame( height: 150)
                            .onAppear(){
                                self.verifyEndList(for: records[index])
                            }
                    }
                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBackground), .clear]), startPoint: .trailing, endPoint: .leading)).frame(width: 75, height: .infinity)
                }
            }.listRowSeparator(.hidden)
        }.listStyle(.plain)
            .refreshable {
                onRefresh()
                self.verifyEndList(for: viewModel.records.last!)
            }
    }
}
