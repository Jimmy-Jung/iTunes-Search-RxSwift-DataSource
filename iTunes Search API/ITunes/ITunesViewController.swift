//
//  ViewController.swift
//  iTunes Search API
//
//  Created by 정준영 on 2023/11/08.
//

import UIKit
import JimmyKit
import RxSwift
import RxCocoa
import RxDataSources

struct ITunesModel: SectionModelType {
    var items: [ITunes]
}
extension ITunesModel {
    init(original: ITunesModel, items: [ITunes]) {
        self = original
        self.items = items
    }
}
class ITunesViewController: UIViewController {
    let iTunesviewModel = ITunesViewModel(iTunesService: ITunesService())
    let iTunesView = ITunesView()
    let disposeBag = DisposeBag()
    let searchBar = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
    }
    
    private func configureUI() {
        navigationItem.title = "검색"
        
        searchBar.searchBar.placeholder = "게임, 앱, 스토리 등"
        navigationItem.searchController = searchBar
        view.backgroundColor(.systemBackground)
        view.addSubview(iTunesView)
        iTunesView.tableView.register(ITunesTableViewCell.self, forCellReuseIdentifier: ITunesTableViewCell.identifier)
        iTunesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        let input = ITunesViewModel
            .Input(
                searchButtonTapped: searchBar.searchBar.rx.searchButtonClicked,
                searchBarText: searchBar.searchBar.rx.text.orEmpty
                )
        
        let output = iTunesviewModel.transform(input: input)
        
        output.items
            .map {
                print($0)
                return [ITunesModel(items: $0.results)]
            }
            .bind(to: iTunesView.tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        output.searchBarPlaceHolder
            .bind(to: searchBar.searchBar.rx.placeholder)
            .disposed(by: disposeBag)
        
    }
    
    var datasource: RxTableViewSectionedReloadDataSource<ITunesModel> {
        return RxTableViewSectionedReloadDataSource<ITunesModel>(configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ITunesTableViewCell.identifier, for: indexPath) as! ITunesTableViewCell
            cell.configureCell(with: item)
            return cell
        })
        
        
    }
}

