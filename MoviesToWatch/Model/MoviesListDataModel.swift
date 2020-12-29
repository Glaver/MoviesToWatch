//
//  MoviesListDataModel.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 10/12/20.
//
//
//import Foundation
//
//
//
//class MoviesListDataModel {
//    var delegate: MoviesListDataModelDelegate?
//    
//    func requestData(from category: Int) {
//        func chooseEndpoint(for url: Int) -> URL? {
//            var urlForMovies = Endpoint.topRated.finalURL
//            switch url {
//            case 0: urlForMovies = Endpoint.topRated.finalURL
//            case 1: urlForMovies = Endpoint.popular.finalURL
//            case 2: urlForMovies = Endpoint.upcoming.finalURL
//            case 3: urlForMovies = Endpoint.nowPlaying.finalURL
//            default: break
//            }
//            return urlForMovies
//        }
//
//        NetworkService.shared.fetchMoviesList(from: chooseEndpoint(for: category)) { (result: Result<MovieDataDTO, APIServiceError>) in
//            switch result {
//                case .success(let movieResponse)://MARK: - Error Handling
//                    //print(movieResponse.results)
//                    self.setData(movieList: movieResponse.results)
//                case .failure(let error):
//                    print(error.localizedDescription)
//            }
//        }
//    }
//
//    func requestDataSearch(from textField: String) {
//        NetworkService.shared.fetchMoviesSearch(from: textField) { (result: Result<MovieDataDTO, APIServiceError>) in
//            switch result {
//                case .success(let movieResponse):
//                    //print(movieResponse.results)
//                    self.setData(movieList: movieResponse.results)
//                case .failure(let error):
//                    print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func setData(movieList: [MovieModel]) -> Void {
//        let data = movieList
//        delegate?.didRecive(data: data)
//    }
//}
