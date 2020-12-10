//
//  MoviesListDataModel.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 10/12/20.
//

import Foundation

protocol MoviesListDataModelDelegate {
    func didRecive(data: [MovieModel])
    func didFail(with error: APIServiceError)
}

class MoviesListDataModel {
    var delegate: MoviesListDataModelDelegate?
    
    func requestData() {
        NetworkService.shared.fetchMoviesList(from: Endpoint.popular.finalURL) { (result: Result<MovieDataDTO, APIServiceError>) in
            switch result {
                case .success(let movieResponse)://MARK: - Error Handling
                    //print(movieResponse.results)
                    self.setData(movieList: movieResponse.results)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func setData(movieList: [MovieModel]) -> Void {
        let data = movieList
        delegate?.didRecive(data: data)
    }
}
