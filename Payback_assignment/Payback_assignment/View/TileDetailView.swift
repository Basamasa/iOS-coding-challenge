//
//  TileDetailView.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 30.07.22.
//

import SwiftUI
import AVKit

struct TileDetailView: View {
    var tile: Tile
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text(tile.headline)
                    .foregroundColor(Color.blue)
                    .bold()
                Spacer()
            }
            .padding()
            
            if tile.name == .image, let data = tile.data {
                NavigationLink {
                    Text("Details")
                } label: {
                    AsyncImage(url: URL(string: data))
                        .frame(alignment: .center)
                }
            } else if tile.name == .video, let data = tile.data {
                VideoPlayer(player: AVPlayer(url:  URL(string: data)!))
                    .frame(height: 400)
            } else if tile.name == .website, let data = tile.data   {
                Text(.init("This is a link [\(tile.name)](\(data)"))
            } else if tile.name == .shopping_list {
                
            }
            HStack {
                Text(tile.subline ?? "")
                    .foregroundColor(Color.blue)
                    .opacity(0.8)
                Spacer()
            }
            .padding()
        }
    }
}

struct TileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TileDetailView(tile: Tile(name: .image, headline: "Image", subline: "Image name", data: nil, score: 1))
    }
}
