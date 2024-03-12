//
//  AsyncImageHelpers.swift
//  Reality Capture
//
//  Created by 罗天宁 on 26/04/2022.
//

import AVFoundation
import Combine
import Foundation
import SwiftUI

/// This class handles image loading for a single image and its corresponding thumbnail.
class AsyncImageStore: ObservableObject {
    var url: URL
    
    @Published var thumbnailImage: UIImage
    @Published var image: UIImage
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let errorImage: UIImage
    
    /// This initializes a data store object that loads a specified image and its corresponding thumbnail.
    init(url: URL, loadingImage: UIImage = UIImage(systemName: "questionmark.circle")!,
         errorImage: UIImage = UIImage(systemName: "xmark.circle")!) {
        self.url = url
        self.thumbnailImage = loadingImage
        self.image = loadingImage
        self.errorImage = errorImage
    }
    
    /// This method starts an asynchronous load of the thumbnail image.
    func loadThumbnail() {
        ImageLoader.loadThumbnail(url: url)
            .receive(on: DispatchQueue.main)
            .replaceError(with: errorImage)
            .assign(to: \.thumbnailImage, on: self)
            .store(in: &subscriptions)
    }
    
    /// This method starts an asynchronous load of the full-size image. If it doesn't find an image at the
    /// specified URL, it publishes an error image.
    func loadImage() {
        ImageLoader.loadImage(url: url)
            .receive(on: DispatchQueue.main)
            .replaceError(with: errorImage)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
    }
}

/// This view displays a thumbnail from a URL. It begins loading the thumbnail asynchronously when
/// it first appears on screen. While loading, this view displays a placeholder image. If it encounters an error,
/// it displays an error image. You must call the `load()` function to start asynchronous loading.
struct AsyncThumbnailView: View {
    let url: URL
    
    @StateObject private var imageStore: AsyncImageStore
    
    init(url: URL) {
        self.url = url
        
        // Initialize the image store with the provided URL.
        _imageStore = StateObject(wrappedValue: AsyncImageStore(url: url))
    }
    
    var body: some View {
        Image(uiImage: imageStore.thumbnailImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .onAppear() {
                imageStore.loadThumbnail()
            }
    }
}

struct AsyncImageView: View {
    let url: URL
    @StateObject private var imageStore: AsyncImageStore
    
    init(url: URL) {
        self.url = url
        
        _imageStore = StateObject(wrappedValue: AsyncImageStore(url: url))
    }
    
    var body: some View {
        Image(uiImage: imageStore.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .onAppear() {
                imageStore.loadImage()
            }
    }
}
