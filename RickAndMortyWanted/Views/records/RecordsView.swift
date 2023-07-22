//
//  RecordsView.swift
//  RickAndMortyWanted
//
//  Created by Iago on 29/06/23.
//

import SwiftUI

struct RecordsView: View {
    
    @State private var search: String = ""
    @ObservedObject var viewModel = RecordsViewModel()
    
    var body: some View {
        VStack{
            Search(placeHolder: "Search Records",search: $search, onPress: { name in
                viewModel.filterRecord(name: name)
            })
            if(viewModel.recordsFiltered.isEmpty && !search.isEmpty){
                Text("No Record Found")
                    .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }else{
                RecordsList(viewModel:viewModel,isFiltered: !search.isEmpty, onRefresh: onRefresh)
            }
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
    
    func onRefresh(){
        search = ""
        viewModel.getRecords()
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView()
    }
}
