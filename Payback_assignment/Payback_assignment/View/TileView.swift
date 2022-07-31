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
        HStack {
            Text(viewModel.tile.headline)
                .foregroundColor(Color.blue)
                .bold()
            Spacer()
        }
        .padding()
    }
    
    /// Show image view
    func imageView(data: String) -> some View {
        HStack {
            Spacer()
            AsyncImage(url: URL(string: data)) { phase in
                switch phase {
                   case .empty:
                       ProgressView()
                   case .success(let image):
                       image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                   case .failure:
                       Image(systemName: "photo")
                        .resizable()
                        .frame(width: 200, height: 200)
                   @unknown default:
                       EmptyView()
                   }
            }
            Spacer()
        }
    }
    
    /// Show playable video view
    func videoView(data: String) -> some View {
        VideoPlayer(player: AVPlayer(url:  URL(string: data)!))
            .frame(height: 400)
    }
        
    /// Show website preview
    @ViewBuilder
    func websiteView() -> some View {
        if let uiImage = viewModel.image {
            HStack {
                Spacer()
                Image(uiImage: uiImage)
                Spacer()
            }
        }
    }
    
    /// Show text field view
    var textFieldView: some View {
        TextField("Type something...", text: $viewModel.text)
    }
    
    /// Show subline view
    var subLine: some View {
        NavigationLink {
            TileDetailView(tile: viewModel.tile)
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
    
    @StateObject var model = WebViewModel()
    @State var showWebView = false

    var body: some View {
        VStack(alignment: .leading){
            headLine
            if viewModel.tile.name == .image, let data = viewModel.tile.data {
                imageView(data: data)
            } else if viewModel.tile.name == .video, let data = viewModel.tile.data {
                videoView(data: data)
            } else if viewModel.tile.name == .website {
                websiteView()
            } else if viewModel.tile.name == .shopping_list {
                textFieldView
            }
            subLine
        }
        .cardStyle()
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(viewModel: TileViewModel(tile: Tile(name: .image, headline: "Image", subline: "Image name", data: nil, score: 1)))
    }
}
