//
//  TileVideoView.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 31.07.22.
//

import SwiftUI
import AVKit

struct TileVideoView: View {
    var data: String

    var body: some View {
        VideoPlayer(player: AVPlayer(url:  URL(string: data)!))
            .frame(height: 400)
    }
}

struct TileVideoView_Previews: PreviewProvider {
    static var previews: some View {
        TileVideoView(data: "")
    }
}
