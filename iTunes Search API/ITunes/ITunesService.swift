//
//  iTunesService.swift
//  iTunes Search API
//
//  Created by 정준영 on 2023/11/08.
//

import Foundation
import Alamofire
import RxSwift

protocol ITunesServiceProtocol {
    func fetchITunesData(with term: String) -> Observable<iTunseResults>
}

struct ITunesService: ITunesServiceProtocol {
    func fetchITunesData(with term: String) -> Observable<iTunseResults> {
        return Observable.create { observer in
            // Alamofire를 사용하여 네트워크 요청 수행
            AF.request("https://itunes.apple.com/search?term=\(term)&entity=software&country=kr").responseDecodable(of: iTunseResults.self) { response in
                switch response.result {
                case .success(let results):
                    observer.onNext(results)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}


struct ITunesService_Test: ITunesServiceProtocol {
    enum ITunesError: Error {
        case loadFile
        case parseData
        case parseJSON
    }
    func fetchITunesData(with term: String) -> RxSwift.Observable<iTunseResults> {
        let data = iTunseResults(resultCount: 1, results: [ITunes(supportedDevices: ["Device"], artworkUrl60: "", artworkUrl512: "", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/1c/e1/9e/1ce19edd-5fe4-cffc-1d96-bb0e85dfd0d5/AppIcon-0-1x_U007ephone-0-85-220.png/100x100bb.jpg", artistViewUrl: "", screenshotUrls: [], isGameCenterEnabled: true, kind: "", primaryGenreName: "Fitness", primaryGenreId: 1, genreIds: [], artistId: 1, artistName: "정준영", genres: [], price: 1100, isVppDeviceBasedLicensingEnabled: true, currentVersionReleaseDate: Date(), description: "", releaseNotes: "", trackId: 1, trackName: "짐핏", bundleId: "", releaseDate: Date(), sellerName: "", currency: "", trackViewUrl: "", minimumOsVersion: "", averageUserRatingForCurrentVersion: 1, trackCensoredName: "", languageCodesISO2A: [], fileSizeBytes: "", formattedPrice: "", userRatingCountForCurrentVersion: 1, averageUserRating: 1, trackContentRating: "", contentAdvisoryRating: "", version: "", wrapperType: "", userRatingCount: 1)])
       
            return Observable.create { observer in
                observer.onNext(data)
                return Disposables.create()
            }
        }
    
//    func fetchITunesData(with term: String) -> RxSwift.Observable<iTunseResults> {
//        let data = parseDataToITunesModel()
//        switch data {
//        case .success(let data):
//            return Observable.create { observer in
//                observer.onNext(data)
//                return Disposables.create()
//            }
//        case .failure(let error):
//            return Observable.create { observer in
//                observer.onError(error)
//                return Disposables.create()
//            }
//        }
//    }
    
    private func loadITunesJSONFile() -> Result<Data, ITunesError> {
        guard let fileLocation = fileLocation(fileName: "ITunesTest", withExtension: .json) else {
            return .failure(.loadFile)
        }
        do {
            let data = try Data(contentsOf: fileLocation)
            return .success(data)
        } catch {
            return .failure(.parseData)
        }
    }
    
    enum Extension: String {
        case json
    }
    
    func fileLocation(fileName: String, withExtension: Extension) -> URL? {
        return Bundle.main.url(forResource: fileName, withExtension: withExtension.rawValue)
    }
    
    private func parseDataToITunesModel() -> Result<iTunseResults, ITunesError> {
        let data = loadITunesJSONFile()
        switch data {
        case .success(let data):
            return parseJSON(data: data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func parseJSON(data: Data) -> Result<iTunseResults, ITunesError> {
        do {
            let decoder = JSONDecoder()
            let iTunesData = try decoder.decode(iTunseResults.self, from: data)
            return .success(iTunesData)
        } catch {
            return .failure(.parseJSON)
        }
    }
    
}
