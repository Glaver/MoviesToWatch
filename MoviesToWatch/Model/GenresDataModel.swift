//
//  GenresDataModel.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 15/12/20.
//

import Foundation

protocol GenresDataModelDelegate {
    func didRecive(data: [GenresDTO])
    func didFail(error: APIServiceError)
}

class GenresDataModel {
    var delegate: GenresDataModelDelegate?
    
    func requestData() {
        NetworkService.shared.fetchMovieGenres(from: Endpoint.movieGenres.finalURL) { (result: Result<[GenresDTO], APIServiceError>) in
            switch result {
                case .success(let genresArray)://MARK: - Error Handling
                    print(genresArray)
                    self.setData(genres: genresArray)
                case .failure(let error):
                    print("Genres" + error.localizedDescription)
            }
        }
    }
    
    func setData(genres: [GenresDTO]) -> Void {
        let data = genres
        delegate?.didRecive(data: data)
    }
}
