//
//  iTunesViewModel.swift
//  iTunes Search API
//
//  Created by 정준영 on 2023/11/08.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    var disposeBag: DisposeBag { get }
    func transform(input: Input) -> Output
}

final class ITunesViewModel: ViewModelType {
    
    struct Input {
        let searchButtonTapped: ControlEvent<Void> // searchBar.rx.searchButtonClicked
        let searchBarText: ControlProperty<String> // searchBar.rx.text.orEmpty
    }
    
    struct Output {
        let items: PublishSubject<ITunseResults>
        let searchBarPlaceHolder: PublishRelay<String>
    }
    
    let iTunesService: ITunesServiceProtocol
    let disposeBag = DisposeBag()
    
    init(iTunesService: ITunesServiceProtocol) {
        self.iTunesService = iTunesService
    }
    
    func getTunesData(term: String) -> Observable<ITunseResults> {
        return iTunesService.fetchITunesData(with: term)
    }
    
    func transform(input: Input) -> Output {
        let iTunesList = PublishSubject<ITunseResults>()
        let searchBarPlaceHolder = PublishRelay<String>()
        fetchITunesDateWhenSearchButtonTapped(input: input)
            .subscribe(
                with: self,
                onNext: { owner, value in
                    iTunesList.onNext(value)
                },
                onError: { owner, error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
        
        input
            .searchBarText
            .changed
            .map { $0.isEmpty ? "게임, 앱, 스토리 등" : ""}
            .bind(to: searchBarPlaceHolder)
            .disposed(by: disposeBag)
        
        return Output(items: iTunesList, searchBarPlaceHolder: searchBarPlaceHolder)
        
    }
    
    func fetchITunesDateWhenSearchButtonTapped(input: Input) -> Observable<ITunseResults> {
        return Observable.combineLatest(input.searchButtonTapped, input.searchBarText)
            .withUnretained(self)
            .flatMap { owner, value in
                print(value)
                return owner.iTunesService.fetchITunesData(with: value.1)
            }
    }
}
