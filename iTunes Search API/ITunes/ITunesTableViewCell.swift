//
//  iTunesTableViewCell.swift
//  iTunes Search API
//
//  Created by 정준영 on 2023/11/08.
//

import UIKit
import Kingfisher

final class ITunesTableViewCell: UITableViewCell {
   
    let artworkImageView = UIImageView().builder
        .contentMode(.scaleAspectFit)
        .build()
    
    let titleLabel = UILabel().builder
        .numberOfLines(0)
        .build()
    
    let artistLabel = UILabel().builder
        .font(.systemFont(ofSize: 12))
        .textColor(.systemGray)
        .build()
    
    let genreLabel = UILabel().builder
        .font(.systemFont(ofSize: 12))
        .textColor(.systemGray)
        .build()
    
    let releaseDateLabel = UILabel().builder
        .font(.systemFont(ofSize: 12))
        .textColor(.systemGray)
        .build()
    
    lazy var stackView = UIStackView().builder
        .axis(.vertical)
        .spacing(5)
        .build()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureStackView()
    }
    
    func configureUI() {
        self.contentView.addSubview(artworkImageView)
        self.contentView.addSubview(stackView)
        
        artworkImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(artworkImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    func configureCell(with item: ITunes) {
        titleLabel.text = item.trackName
        artistLabel.text = item.artistName
        genreLabel.text = item.primaryGenreName
        releaseDateLabel.text = item.releaseDate.convert(to: .defaultForm)
        artworkImageView
            .kf
            .setImage(
                with: URL(string: item.artworkUrl100),
                placeholder: UIImage(named: "placeholder")
            )
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(artistLabel)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(releaseDateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
