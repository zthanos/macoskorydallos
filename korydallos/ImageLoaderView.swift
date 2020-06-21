//
//  ImageLoaderView.swift
//  korydallos
//
//  Created by user172589 on 8/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? {get set }
}

struct TemporaryImageCache: ImageCache{
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

struct ImageCacheKey: EnvironmentKey{
    static let defaultValue: ImageCache = TemporaryImageCache()
}
extension EnvironmentValues{
    var imageCache: ImageCache{
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}

class ImageLoader: ObservableObject{
    @Published var image : UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?
    private var cache: ImageCache?
    private(set) var isLoading = false
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL, cache: ImageCache? = nil){
        self.url = url
        self.cache = cache
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    func load(){
        guard !isLoading else { return }
        
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: Self.imageProcessingQueue)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
        
        
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0}
    }
    
    func cancel(){
        cancellable?.cancel()
    }
    
    private func onStart(){
        isLoading = true
    }
    private func onFinish(){
        isLoading = false
    }
    
}

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder?
    private let configuration: (Image) -> Image
    
    
    init(url: URL, placeholder: Placeholder? = nil, cache: ImageCache? = nil, configuration: @escaping(Image) -> Image = { $0 }) {
        loader = ImageLoader(url: url, cache: cache)
        self.placeholder = placeholder
        self.configuration = configuration
    }
    
    var body : some View {
        
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
    
    private var image : some View {
        Group {
            if loader.image != nil {
                configuration(Image(uiImage: loader.image!))
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}


