//
//  File.swift
//  PRORecipies
//
//  Created by Anvar on 15.04.2023.
//

import SwiftUI

struct CacheAsyncImage<Content, Placeholder: View>: View where Content: View {
    @Environment(\.imageCache) var cache: ImageCache

    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (Image) -> Content
    private let placeholder: () -> Placeholder

    init(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
        self.placeholder = placeholder
    }

    var body: some View {
        if let url {
            if let cached = cache.getImage(for: url) {
                content(cached)
            } else {
                AsyncImage(
                    url: url,
                    content: { cacheAndRender(image: $0, for: url) },
                    placeholder: { placeholder() }
                )
            }
        } else {
            placeholder()
        }
    }

    func cacheAndRender(image: Image, for url: URL) -> some View {
        cache.setImage(image: image, for: url)
        return content(image)
    }
}
