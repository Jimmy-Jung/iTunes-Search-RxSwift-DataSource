//
//  iTunes.swift
//  iTunes Search API
//
//  Created by 정준영 on 2023/11/08.
//

import Foundation
import RxDataSources

// MARK: - Welcome
struct iTunseResults: Codable {
    let resultCount: Int
    var results: [ITunes]
}

// MARK: - Result
struct ITunes: Codable {
    let supportedDevices: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistViewUrl: String
    let screenshotUrls: [String]
    let isGameCenterEnabled: Bool
    let kind, primaryGenreName: String
    let primaryGenreId: Int
    let genreIds: [String]
    let artistId: Int
    let artistName: String
    let genres: [String]
    let price: Int
    let isVppDeviceBasedLicensingEnabled: Bool
    let currentVersionReleaseDate: Date
    let description, releaseNotes: String
    let trackId: Int
    let trackName, bundleId: String
    let releaseDate: Date
    let sellerName, currency: String
    let trackViewUrl: String
    let minimumOsVersion: String
    let averageUserRatingForCurrentVersion: Int
    let trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes, formattedPrice: String
    let userRatingCountForCurrentVersion, averageUserRating: Int
    let trackContentRating, contentAdvisoryRating, version, wrapperType: String
    let userRatingCount: Int
}
