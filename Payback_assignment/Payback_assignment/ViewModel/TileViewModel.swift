//
//  TileViewModel.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 30.07.22.
//

import UIKit
import LinkPresentation
import Combine

final class TileViewModel : ObservableObject {
    let metadataProvider = LPMetadataProvider()
    @Published var metadata: LPLinkMetadata?
    @Published var image: UIImage?
    var tile: Tile
    @Published var text = ""
    private var canc: AnyCancellable!
    
    init(tile: Tile) {
        self.tile = tile
        canc = $text.debounce(for: 1, scheduler: DispatchQueue.main).sink { newText in
            HistorySearch.insertHistory(text: newText)
        }
        guard tile.name == .website else {return}
        guard let data = tile.data else {return}
        guard let url = URL(string: data) else {return}
        
        metadataProvider.startFetchingMetadata(for: url) { (metadata, error) in
            guard error == nil else {
                print("Error")
                return
            }
            DispatchQueue.main.async {
                self.metadata = metadata
            }
            guard let imageProvider = metadata?.imageProvider else { return }
            imageProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                guard error == nil else {
                    return
                }
                if let image = image as? UIImage {
                    // do something with image
                    DispatchQueue.main.async {
                        self.image = image
                    }
                } else {
                    print("no image available")
                }
            }
        }
    }
    
    deinit {
        canc.cancel()
    }
}
