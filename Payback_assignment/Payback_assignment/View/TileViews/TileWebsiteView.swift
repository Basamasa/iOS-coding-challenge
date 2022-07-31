//
//  TileWebsiteView.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 31.07.22.
//

import SwiftUI

struct TileWebsiteView: View {
    var image: UIImage?
    var model: WebViewModel
    var isDetailView: Bool
    
    var body: some View {
        if isDetailView {
            WebView(webView: model.webView)
        } else {
            if let uiImage = image {
                HStack {
                    Spacer()
                    Image(uiImage: uiImage)
                }
            } else {
                HStack {
                    Spacer()
                    Image(systemName: "link")
                     .resizable()
                     .frame(width: 200, height: 200)
                    Spacer()
                }
            }
        }
    }
}

struct TileWebsiteView_Previews: PreviewProvider {
    static var previews: some View {
        TileWebsiteView(image: nil, model: WebViewModel(urlName: "www.google.com"), isDetailView: false)
    }
}
