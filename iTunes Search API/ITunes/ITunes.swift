//
//  iTunes.swift
//  iTunes Search API
//
//  Created by 정준영 on 2023/11/08.
//

import Foundation
import RxDataSources

// MARK: - Welcome
struct ITunseResults: Codable {
    let resultCount: Int
    var results: [ITunes]
}

// MARK: - Result
struct ITunes: Codable {
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let screenshotUrls: [String]
    let genreIds: [String]
    let genres: [String]
    let trackName, bundleId: String
    let averageUserRating: Double
}
