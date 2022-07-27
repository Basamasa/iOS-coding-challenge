//
//  ContentViewModel.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 26.07.22.
//

import Foundation

class ContentViewModel: ObservableObject {
    private(set) var tiles = [Tile]()
    var dataUpdated: (() -> Void)?
    /**
     Fetch results
     
     - Parameters:
        - completion: Handler to retrieve result
     */
    func fetchResults() async {
        let result = await PayBackAPI().requestFeed()
        
        DispatchQueue.main.async {
            switch result {
            case .Success(let results):
                if let result = results {
                    self.tiles = result.tiles
                    self.dataUpdated?()
                }
            case .Failure(let message):
                print(message)
            case .Error(let error):
                print(error)
            }
        }
    }
}
