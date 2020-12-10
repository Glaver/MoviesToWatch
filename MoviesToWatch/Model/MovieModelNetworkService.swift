//
//  MovieModelNetworkService.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 10/12/20.
//

import Foundation

class MovieModelNetworkService {
    public static let shared = MovieModelNetworkService()

    private func fetchDataFrom<T: Decodable>(_ url: URL?, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard let finalURL = url else {
            completion(.failure(.invalidEndpoint))
            return
        }
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
    //MARK: FetchMovieList
    public func fetchMoviesList(from endpoint: URL?, result: @escaping (Result<MovieDataDTO, APIServiceError>) -> Void) {
        fetchDataFrom(endpoint, completion: result)
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
