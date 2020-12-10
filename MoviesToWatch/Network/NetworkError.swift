//
//  NetworkError.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 10/12/20.
//

import Foundation

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}
