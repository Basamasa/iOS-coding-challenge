//
//  TileView.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 27.07.22.
//

import SwiftUI
import AVKit

struct TileView: View {
    @StateObject var viewModel: TileViewModel
    
    /// Headline
    var headLine: some View {
        NavigationLink {
            TileDetailView(viewModel: viewModel)
        } label: {
            HStack {
                Text(viewModel.tile.headline)
                    .foregroundColor(Color.blue)
                    .bold()
                Spacer()
            }
        }
        .padding()
    }
    
    /// Show subline view
    var subLine: some View {
        NavigationLink {
            TileDetailView(viewModel: viewModel)
        } label: {
            HStack {
                if viewModel.tile.name == .website, let data = viewModel.tile.data  {
                    Text(.init("Link: \(data)"))
                } else {
                    Text(viewModel.tile.subline ?? "")
                        .foregroundColor(Color.blue)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.blue)
            }
        }
        .padding()
    }

    var body: some View {
        VStack(alignment: .leading) {
            headLine
            if viewModel.tile.name == .image, let data = viewModel.tile.data {
                NavigationLink {
                    TileDetailView(viewModel: viewModel)
                } label: {
                    TileImageView(data: data)
                }
            } else if viewModel.tile.name == .video, let data = viewModel.tile.data {
                TileVideoView(data: data)
            } else if viewModel.tile.name == .website, let data = viewModel.tile.data {
                NavigationLink {
                    TileDetailView(viewModel: viewModel)
                } label: {
                    TileWebsiteView(image: viewModel.image, model: WebViewModel(urlName: data), isDetailView: false)
                }
            } else if viewModel.tile.name == .shopping_list {
                TileTextFieldView(text: $viewModel.text)
            }
            subLine
        }
        .cardStyle()
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(viewModel: TileViewModel(tile: Tile(item: Item())))
    }
}
