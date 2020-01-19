//
//  model.swift
//  HapoalimSwiftUIRX
//
//  Created by Arie Guttman on 07/01/2020.
//  Copyright © 2020 Arie Guttman. All rights reserved.
//

import SwiftUI
import Combine


class PageModel: ObservableObject, Identifiable {
    var id = UUID()
    var name: String
    @Published var image: UIImage?
    var siteImageURL: String?
    private var cancellableResult: AnyCancellable?
        
    init() {
        name = ""
        siteImageURL = nil
    }
    
    init(name: String, imageURLString: String?) {
        self.siteImageURL = imageURLString
        self.name = name
    }
    
    func updateImage(image: UIImage) {
        self.image = image
    }
    
    func fetchImage() {
        guard
            let siteImageURL = siteImageURL,
            let url = URL(string: siteImageURL) else {
                return
        }
        
        let request = URLRequest(url: url)
        cancellableResult = URLSession.shared.dataTaskPublisher(for: request)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] image in
                self?.image = image
            })
    }
    
    func cancelImageRequest() {
        cancellableResult?.cancel()
    }
    
}
