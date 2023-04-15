//
//  ImageCache.swift
//  PRORecipies
//
//  Created by Anvar on 15.04.2023.
//

import SwiftUI

final class ImageCache: ObservableObject {
    private let dispatchQueue = DispatchQueue(label: "collection-thread", attributes: .concurrent)

    private var cache: [URL: Image] = [:]
    private var queueCache = [URL]()

    func getImage(for url: URL) -> Image? {
        var image: Image?
        dispatchQueue.sync { [weak self] in
            guard let self else { return }

            image = self.cache[url]
        }
        return image
    }

    func setImage(image: Image, for url: URL) {
        dispatchQueue.async(flags: .barrier) { [weak self] in
            guard let self else { return }

            self.cache[url] = image
            self.queueCache.append(url)

            if self.cache.count > 30 {
                self.cache.removeValue(forKey: self.queueCache.removeFirst())
            }
        }
    }

}
