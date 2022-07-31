//
//  TileTextFieldView.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 31.07.22.
//

import SwiftUI

struct TileTextFieldView: View {
   @Binding var text: String

    var body: some View {
        VStack {
            TextField("Type something...", text: $text)
                .textFieldStyle(.roundedBorder)
            
            ForEach(HistorySearch.historySearches, id: \.self) { element in
                HStack {
                    Text(element)
                    Spacer()
                }
            }

        }
        .padding()
    }
}

struct TileTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TileTextFieldView(text: .constant(""))
    }
}
