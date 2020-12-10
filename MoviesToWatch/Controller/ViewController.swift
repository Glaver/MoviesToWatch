//
//  ViewController.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 9/12/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieModelNetworkService.shared.fetchMoviesList(from: Endpoint.popular.finalURL) { (result: Result<MovieDataDTO, APIServiceError>) in
            switch result {
                case .success(let movieResponse):
                    print(movieResponse.results)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        // Do any additional setup after loading the view.
    }


}

