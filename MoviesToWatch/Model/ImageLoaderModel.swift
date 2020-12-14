//
//  ImageLoaderModel.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 12/12/20.
//

import Foundation
import UIKit

protocol ImageLoaderModelDelegate {
    func didRecive(data: UIImage)
    func didFail(with error: APIServiceError)
}

class ImageLoaderModel {
    var delegate: ImageLoaderModelDelegate?
    
    func requestData() {
        NetworkService.shared.fetchImage(from: ImageAPI.Size.medium.path(poster: "/xfYMQNApIIh8KhpNVtG1XRz0ZAp.jpg")) { (result: Result<Data, APIServiceError>) in
            switch result {
                case .success(let movieResponse)://MARK: - Error Handling
                    //print(movieResponse.results)
                    self.setData(image: movieResponse)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func setData(image: Data?) -> Void {
        if let data = image {
            delegate?.didRecive(data: UIImage(data: data) ?? UIImage(named: "blur")!)
        }
    }
}
