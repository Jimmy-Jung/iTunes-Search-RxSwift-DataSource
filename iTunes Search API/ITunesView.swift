//
//  iTunesView.swift
//  iTunes Search API
//
//  Created by 정준영 on 2023/11/08.
//

import UIKit
import SnapKit

final class ITunesView: UIView {
    let searchBar = UISearchBar().builder
        .placeholder("검색어를 입력하세요.")
        .build()
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    func configureUI() {
        self.addSubview(searchBar)
        self.addSubview(tableView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
