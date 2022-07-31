//
//  ContentView.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 26.07.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.score, ascending: false)], animation: .default) var items: FetchedResults<Item>
    @ObservedObject var viewModel: ContentViewModel

    init(viewContext: NSManagedObjectContext) {
        self.viewModel = ContentViewModel(viewContext: viewContext)
    }
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    ForEach(items, id: \.self) { item in
                        TileView(viewModel: TileViewModel(tile: Tile(item: item)))
                    }
                    .navigationTitle("PayBack")
                }
            }
        }
        .task {
            await viewModel.fetchResults()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewContext: PersistenceController.shared.container.viewContext).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
