//
//  Ext+YoutubeLink.swift
//  PRORecipies
//
//  Created by Anvar on 19.04.2023.
//

import Foundation

public extension String {
    func makeYoutubeLink() -> String {
        let url = self
        let videoIndex = String(url.split(separator: /\?v=/).last ?? "")
        let urlNew = "https://www.youtube.com/embed/\(videoIndex)/"
        return urlNew
    }
}
