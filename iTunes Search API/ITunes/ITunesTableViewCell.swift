//
//  iTunesTableViewCell.swift
//  iTunes Search API
//
//  Created by 정준영 on 2023/11/08.
//

import UIKit
import Kingfisher
import Then

final class ITunesTableViewCell: UITableViewCell {
   
    let iconImageView = UIImageView(frame: .zero).then {
        $0.layer.cornerRadius = 14
        $0.layer.masksToBounds = true
    }
    let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textColor = .label
        $0.text = "짐핏"
    }
    let subtitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .secondaryLabel
        $0.text = "피트니스"
    }
    let rateView = UIView()
    let rateLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .secondaryLabel
        $0.text = "5"
    }
    
    let downloadButton = UIButton(configuration: .gray()).then {
        $0.setTitle("받기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 14
    }
    
    let appImageStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 8
    }
    
    let firstScreenShotImageView = UIImageView().then {
        $0.image = UIImage(named: "placeholder")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 11
        $0.layer.masksToBounds = true
    }
    let secondScreenShotImageView = UIImageView().then {
        $0.image = UIImage(named: "placeholder")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 11
        $0.layer.masksToBounds = true
    }
    let thirdScreenShotImageView = UIImageView().then {
        $0.image = UIImage(named: "placeholder")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 11
        $0.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        firstScreenShotImageView.image = nil
        secondScreenShotImageView.image = nil
        thirdScreenShotImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subviews()
        setConstraints()
    }
    func configureCell(with item: ITunes) {
        iconImageView.kf.setImage(with: URL(string: item.artworkUrl100), placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.7))])
        titleLabel.text = item.trackName
        subtitleLabel.text = item.genres.joined(separator: ", ")
        rateLabel.text = String(format: "%.1f", item.averageUserRating)
        firstScreenShotImageView.kf.setImage(with: URL(string: item.screenshotUrls[safe: 0] ?? ""), placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.7))])
        secondScreenShotImageView.kf.setImage(with: URL(string: item.screenshotUrls[safe: 1] ?? ""), placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.7))])
        thirdScreenShotImageView.kf.setImage(with: URL(string: item.screenshotUrls[safe: 2] ?? ""), placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.7))])
    }
    
    private func subviews() {
        [iconImageView,
         titleLabel, subtitleLabel, rateLabel,
         downloadButton, appImageStackView].forEach { [weak self] view in
            self?.contentView.addSubview(view)
        }
        [firstScreenShotImageView,
         secondScreenShotImageView,
         thirdScreenShotImageView].forEach { [weak self] imageview in
            self?.appImageStackView.addArrangedSubview(imageview)
        }
//        appImageStackView.backgroundColor(.cyan)
    }
    
    private func setConstraints() {
        iconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(22)
            $0.size.equalTo(62)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.top)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-10)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        rateLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.bottom.equalTo(iconImageView.snp.bottom)
        }
        
        downloadButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(38)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(80)
            $0.height.equalTo(28)
        }
        
        appImageStackView.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.size.width / (1192/696))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
