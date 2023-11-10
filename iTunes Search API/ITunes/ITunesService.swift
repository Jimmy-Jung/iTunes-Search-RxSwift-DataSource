//
//  iTunesService.swift
//  iTunes Search API
//
//  Created by 정준영 on 2023/11/08.
//

import Foundation
import Alamofire
import RxSwift
import JimmyKit

protocol ITunesServiceProtocol {
    func fetchITunesData(with term: String) -> Observable<ITunseResults>
}

struct ITunesService: ITunesServiceProtocol {
    func fetchITunesData(with term: String) -> Observable<ITunseResults> {
        return Observable.create { observer in
            // Alamofire를 사용하여 네트워크 요청 수행
            AF.request("https://itunes.apple.com/search?term=\(term)&media=software&country=kr".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "").responseDecodable(of: ITunseResults.self) { response in
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
    
    func fetchITunesData(with term: String) -> RxSwift.Observable<ITunseResults> {
        let data = parseDataToITunesModel()
        switch data {
        case .success(let data):
            return Observable.create { observer in
                observer.onNext(data)
                return Disposables.create()
            }
        case .failure(let error):
            return Observable.create { observer in
                observer.onError(error)
                return Disposables.create()
            }
        }
    }
    
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
    
    private func parseDataToITunesModel() -> Result<ITunseResults, ITunesError> {
        let data = loadITunesJSONFile()
        switch data {
        case .success(let data):
            return parseJSON(data: data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func parseJSON(data: Data) -> Result<ITunseResults, ITunesError> {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let iTunesData = try decoder.decode(ITunseResults.self, from: data)
            return .success(iTunesData)
        } catch {
            return .failure(.parseJSON)
        }
    }
    
}
