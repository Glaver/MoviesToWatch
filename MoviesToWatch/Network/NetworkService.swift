//
//  MovieModelNetworkService.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 10/12/20.
//

import Foundation
import UIKit

protocol MovieListService {
    func fetchMoviesList(from endpoint: URL?, result: @escaping (Result<MovieDataDTO, APIServiceError>) -> Void)
}

class NetworkService: MovieListService {
    public static let shared = NetworkService()
    //MARK: Fetch generic data
    private func fetchDataFrom<T: Decodable>(_ url: URL?, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard let finalURL = url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: finalURL) { (result) in
                switch result {
                case .success(let (response, data)):
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    do {
                        let values = try NetworkAPI.jsonDecoder.decode(T.self, from: data)
                        completion(.success(values))
                    } catch {
                        completion(.failure(.decodeError))
                    }
                case .failure: //case .failure(let error):
                    completion(.failure(.apiError))
                }
            }.resume()
        }
    }
    //MARK: - FetchImage
    private static func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    public static func downloadImage(url: URL, completion: @escaping (Results<Data>) -> Void) {
        self.getData(url: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
    //MARK: - FetchMovieList
    public func fetchMoviesList(from endpoint: URL?, result: @escaping (Result<MovieDataDTO, APIServiceError>) -> Void) {
            self.fetchDataFrom(endpoint, completion: result)
    }
    //MARK: - FetchMovieGenres
    public func fetchMovieGenres(from endpoint: URL?, result: @escaping (Result<[GenresDTO], APIServiceError>) -> Void) {
            self.fetchDataFrom(endpoint, completion: result)
    }
    //MARK: - FetchMovieSearch
    public func fetchMoviesSearch(from string: String, result: @escaping (Result<MovieDataDTO, APIServiceError>) -> Void) {
            self.fetchDataFrom(Endpoint.search(searchString: string).finalURL, completion: result)
        }
}

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}

// Result enum is a generic for any type of value
// with success and failure case
public enum Results<T> {
    case success(T)
    case failure(Error)
}
