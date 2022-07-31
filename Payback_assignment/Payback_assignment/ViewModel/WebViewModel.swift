//
//  WebViewModel.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 31.07.22.
//

import WebKit

class WebViewModel: ObservableObject {
    let webView: WKWebView
    let url: URL
    
    init() {
        webView = WKWebView(frame: .zero)
        url = URL(string: "https://benoitpasquier.com")!

        loadUrl()
    }
    
    func loadUrl() {
        webView.load(URLRequest(url: url))
    }
}
