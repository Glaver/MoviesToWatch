//
//  MovieModel.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 9/12/20.
//https://developers.themoviedb.org/3/movies/get-latest-movie

import Foundation

public struct MovieDataDTO: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [MovieModel]
}

struct MovieModel: Codable, FilterTvShowAndMovies {
    let popularity: Float
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let releaseDate: Date
    let voteAverage: Float
    let voteCount: Int
    let video: Bool
    let adult: Bool
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
}

protocol MovieShowViewProtocol {
    var popularity: Float { get }
    var id: Int { get }
    var title: String { get }
    var backdropPath: String? { get }
    var posterPath: String? { get }
    var genreIds: [Int] { get }
    var overview: String { get }
    var releaseDate: Date { get }
    var voteAverage: Float { get }
}
