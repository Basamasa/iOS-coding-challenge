//
//  ContentView.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 26.07.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>

    @State var text: String = ""
    
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    ForEach(viewModel.tiles, id: \.self) { tile in
                        TileView(viewModel: TileViewModel(tile: tile))
                    }
                    .onDelete(perform: deleteItems)
                    .navigationTitle("PayBack")
                }
            }
        }
        .task {
            await viewModel.fetchResults()
        }
        .environmentObject(viewModel)

    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date() + 1

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
