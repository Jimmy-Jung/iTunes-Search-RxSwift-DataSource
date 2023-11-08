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
    let iTunesviewModel = ITunesViewModel(iTunesService: ITunesService_Test())
    let iTunesView = ITunesView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
    }
    
    private func configureUI() {
        view.backgroundColor(.systemBackground)
        view.addSubview(iTunesView)
        iTunesView.tableView.register(ITunesTableViewCell.self, forCellReuseIdentifier: ITunesTableViewCell.identifier)
        iTunesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        let input = ITunesViewModel
            .Input(searchButtonTapped: iTunesView.searchBar.rx.searchButtonClicked, searchBarText: iTunesView.searchBar.rx.text.orEmpty)
        
        let output = iTunesviewModel.transform(input: input)
        output.items
            .map {
                print($0)
                return [ITunesModel(items: $0.results)]
            }
            .bind(to: iTunesView.tableView.rx.items(dataSource: datasource))
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

