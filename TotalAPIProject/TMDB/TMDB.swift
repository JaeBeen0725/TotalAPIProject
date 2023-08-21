//
//  TMDB.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/21.
//

import Foundation
// MARK: - Lotto
struct TMDBData: Codable {
    let totalPages, page, totalResults: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case page
        case totalResults = "total_results"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let title: String?
    let backdropPath, posterPath: String
    let mediaType: String?
    let releaseDate: String?
    let originalLanguage: String?
    let id: Int
    let adult: Bool
    let voteAverage: Double
    let genreIDS: [Int]
    let overview: String
    let video: Bool?
    let originalTitle: String?
    let voteCount: Int
    let popularity: Double
    let firstAirDate, originalName: String?
    let originCountry: [String]?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case title
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case id, adult
        case voteAverage = "vote_average"
        case genreIDS = "genre_ids"
        case overview, video
        case originalTitle = "original_title"
        case voteCount = "vote_count"
        case popularity
        case firstAirDate = "first_air_date"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case name
    }
}


struct Tmdb: Codable {
    let id: Int
    let cast: [CastTMDB]
}

// MARK: - Cast
struct CastTMDB: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
 
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
   
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
   
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case department, job
    }
}
