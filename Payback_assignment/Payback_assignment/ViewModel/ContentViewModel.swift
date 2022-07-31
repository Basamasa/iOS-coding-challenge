//
//  ContentViewModel.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 26.07.22.
//

import Foundation
import CoreData

final class ContentViewModel: ObservableObject {
    let refreshManager = RefreshManager.shared
    private var viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    private func deleteAll() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            let entriesCoreData = try viewContext.fetch(request)
            for item in entriesCoreData {
                viewContext.delete(item)
            }
            try? viewContext.save()
        } catch {
            print("Fetch failed: Error \(error.localizedDescription)")
        }
    }
    
    private func saveItems(results: (TileList?)) {
        if let result = results {
            for resultTile in result.tiles {
                let item = Item(context: viewContext)
                item.name = resultTile.name.rawValue
                item.subline = resultTile.subline
                item.headline = resultTile.headline
                item.data = resultTile.data
                item.score = Int32(resultTile.score)
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
    /**
     Fetch results  from api after 1(24 hours) day
     
     - Parameters:
        - completion: Handler to retrieve result
     */
    func fetchResults() async {
        let result = await PayBackAPI().requestFeed()
        
        DispatchQueue.main.async {
            self.refreshManager.loadDataIfNeeded() { success in
                if success {
                    switch result {
                    case .Success(let results):
                        self.deleteAll()
                        self.saveItems(results: results)
                    case .Failure(let message):
                        print(message)
                    case .Error(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
