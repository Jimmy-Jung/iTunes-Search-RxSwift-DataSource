//
//  iTunesView.swift
//  iTunes Search API
//
//  Created by 정준영 on 2023/11/08.
//

import UIKit
import SnapKit

final class ITunesView: UIView {
    
    let tableView = UITableView().builder
        .rowHeight(UITableView.automaticDimension)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    func configureUI() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
