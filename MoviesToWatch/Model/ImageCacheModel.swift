//
//  ImageCacheModel.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 10/12/20.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

 //MARK: - UIImageView extension
extension UIImageView {
    func loadThumbnail(urlSting: String) {
        guard let url = ImageAPI.Size.medium.path(poster: urlSting)?.absoluteURL else { return }
        image = nil

        if let imageFromCache = imageCache.object(forKey: urlSting as NSString) {
            image = imageFromCache// as? UIImage
            return
        }
        NetworkService.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlSting as NSString)
                self.image = UIImage(data: data)
            case .failure(_):
                self.image = UIImage(named: "blur")
            }
        }
    }
}
