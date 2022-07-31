//
//  TileViewModel.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 30.07.22.
//

import UIKit
import LinkPresentation
import Combine

class TileViewModel : ObservableObject {
    let metadataProvider = LPMetadataProvider()
    
    @Published var metadata: LPLinkMetadata?
    @Published var image: UIImage?
    
    var tile: Tile
    private static let userDefaultTextKey = "textKey"
    @Published var text = UserDefaults.standard.string(forKey: TileViewModel.userDefaultTextKey) ?? ""
    private var canc: AnyCancellable!
    
    init(tile: Tile) {
        self.tile = tile
        canc = $text.debounce(for: 0.2, scheduler: DispatchQueue.main).sink { newText in
            UserDefaults.standard.set(newText, forKey: TileViewModel.userDefaultTextKey)
        }
        guard tile.name == .website else {return}
        guard let data = tile.data else {return}
        guard let url = URL(string: data) else {return}
        
        metadataProvider.startFetchingMetadata(for: url) { (metadata, error) in
            guard error == nil else {
                assertionFailure("Error")
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
