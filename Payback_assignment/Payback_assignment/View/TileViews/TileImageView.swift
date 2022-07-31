//
//  TileImageView.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 31.07.22.
//

import SwiftUI

struct TileImageView: View {
    var data: String
    
    var body: some View {
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
}

struct TileImageView_Previews: PreviewProvider {
    static var previews: some View {
        TileImageView(data: "")
    }
}
