//
//  Search.swift
//  RickAndMortyWanted
//
//  Created by Iago on 22/07/23.
//

import SwiftUI

struct Search: View {
    
    var placeHolder: LocalizedStringKey
    @Binding var search: String
    var onPress: (_: String) -> Void
  
    
    init(placeHolder: LocalizedStringKey,search: Binding<String>, onPress: @escaping (_: String) -> Void) {
        self.placeHolder = placeHolder
        self.onPress = onPress
        self._search = search
    }
    
    var body: some View {
        TextField(placeHolder, text: $search).onChange(of: search){
           onPress($0)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .frame(maxWidth: .infinity, maxHeight: 40)
        .cornerRadius(10)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
