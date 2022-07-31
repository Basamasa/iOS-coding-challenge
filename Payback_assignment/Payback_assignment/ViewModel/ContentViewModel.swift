//
//  ContentViewModel.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 26.07.22.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published private(set) var tiles = [Tile]()
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
                }
            case .Failure(let message):
                print(message)
            case .Error(let error):
                print(error)
            }
        }
    }
}
