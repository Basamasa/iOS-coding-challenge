//
//  TileDetailView.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 30.07.22.
//

import SwiftUI
import AVKit

struct TileDetailView: View {
    @StateObject var viewModel: TileViewModel
    
    /// Show headline view
    var headLine: some View {
        HStack {
            Spacer()
            Text(viewModel.tile.headline)
                .font(.system(size: 60))
                .foregroundColor(Color.blue)
                .bold()
            Spacer()
        }
        .padding()
    }
    
    /// Show subline view
    var subLine: some View {
        HStack {
            Spacer()
            if viewModel.tile.name == .website, let data = viewModel.tile.data  {
                Text(.init("Link: \(data)"))
            } else {
                Text(viewModel.tile.subline ?? "")
                    .foregroundColor(Color.blue)
            }
            Spacer()
        }
        .padding()
    }
    
    var body: some View {
        VStack(){
            headLine
            if viewModel.tile.name == .image, let data = viewModel.tile.data {
                TileImageView(data: data)
            } else if viewModel.tile.name == .video, let data = viewModel.tile.data {
                TileVideoView(data: data)
            } else if viewModel.tile.name == .website, let data = viewModel.tile.data {
                TileWebsiteView(image: viewModel.image, model: WebViewModel(urlName: data), isDetailView: true)
            } else if viewModel.tile.name == .shopping_list {
                TileTextFieldView(text: $viewModel.text)
            }
            subLine
            Spacer()
        }
    }
}

struct TileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TileDetailView(viewModel: TileViewModel(tile: Tile(item: Item())))
    }
}
