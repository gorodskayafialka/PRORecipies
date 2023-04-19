//
//  YoutubeVideoView.swift
//  PRORecipies
//
//  Created by Anvar on 19.04.2023.
//

import SwiftUI
import WebKit

struct YoutubeVideoView: UIViewRepresentable {
    var youtubeLink: String
    func makeUIView(context: Context) -> WKWebView  {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: youtubeLink) else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: url))
    }
}
