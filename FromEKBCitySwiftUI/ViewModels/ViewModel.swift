//
//  ViewModel.swift
//  FromEKBCitySwiftUI
//
//  Created by Фаниль on 19.06.2024.
//

import SwiftUI

extension LazyGridView {
    @Observable
    class ViewModel {
        var link = "https://it-link.ru/test/images.txt"
        var images = [String]()
        
        init() {
            getImages(link: link, allLinks: false)
        }
        
        func getImages(link: String, allLinks: Bool) {
            DownloadManager.shared.downloadFile(from: link, allLinks: allLinks) { [weak self] images in
                guard let self else { return }
                self.images = images
            }
        }
    }
}
