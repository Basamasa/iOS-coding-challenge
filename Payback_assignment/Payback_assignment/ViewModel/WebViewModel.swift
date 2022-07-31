//
//  WebViewModel.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 31.07.22.
//

import WebKit

final class WebViewModel: ObservableObject {
    let webView: WKWebView
    let url: URL
    
    init(urlName: String) {
        webView = WKWebView(frame: .zero)
        url = URL(string: urlName)!
        loadUrl()
    }
    
    func loadUrl() {
        webView.load(URLRequest(url: url))
    }
}
