//
//  ResultDetailView.swift
//  study4
//
//  Created by 이상민 on 2/10/25.
//

import UIKit
import SnapKit

class ResultDetailView: BaseView {
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var profileUploadDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var profileInfoVStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [profileNameLabel, profileUploadDateLabel])
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var profileHStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [profileImageView, profileInfoVStackView])
        view.axis = .horizontal
        view.spacing = 12
        view.distribution = .fill
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정보"
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        return label
    }()
    
    private lazy var sizeLabel = createKeyLabel(text: "크기")
    private lazy var viewsLabel = createKeyLabel(text: "조회수")
    private lazy var downloadsLabel = createKeyLabel(text: "다운로드")
    
    private lazy var sizeValueLabel = createvalueLabel(text: "-")
    private lazy var viewsValueLabel = createvalueLabel(text: "-")
    private lazy var downloadsValueLabel = createvalueLabel(text: "-")
    
    private lazy var keyStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [sizeLabel, viewsLabel, downloadsLabel])
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .leading
        return view
    }()
    
    
    private lazy var valueStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [sizeValueLabel, viewsValueLabel, downloadsValueLabel])
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .trailing
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [keyStackView, valueStackView])
        view.axis = .horizontal
        return view
    }()
    
    private lazy var boxView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, mainStackView])
        view.spacing = 50
        view.axis = .horizontal
        view.alignment = .top
        return view
    }()
    
    override func configureHierarchy() {
        self.backgroundColor = .white
        self.addSubview(profileHStackView)
        self.addSubview(imageView)
        self.addSubview(boxView)
    }
    
    override func configureLayout() {
        
        self.profileHStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        self.profileImageView.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
        
        self.profileInfoVStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(profileHStackView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        
        self.boxView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(12)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        self.mainStackView.snp.makeConstraints { make in
            make.top.equalTo(boxView)
            make.trailing.equalTo(boxView)
        }
    }
    
    private func createKeyLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        return label
    }
    
    private func createvalueLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 12)
        return label
    }
    
    func configreData(searchResult: SearchResult, resultStatistics: StatisticsResponse){
        self.profileImageView.kf.setImage(with: URL(string: searchResult.user.profile_image.small))
        self.profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        self.profileImageView.layer.masksToBounds = true
        self.profileNameLabel.text = searchResult.user.name
        self.profileUploadDateLabel.text = self.formattedDate(dateText: searchResult.user.updated_at)
        self.imageView.kf.setImage(with: URL(string: searchResult.urls.small))
        self.sizeValueLabel.text = "\(searchResult.width) x \(searchResult.height)"
        self.viewsValueLabel.text = "\(resultStatistics.views.total.formatted(.number))"
        self.downloadsValueLabel.text = "\(resultStatistics.downloads.total.formatted(.number))"
    }
    
    func formattedDate(dateText: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        if let date = isoFormatter.date(from: dateText) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 M월 d일 게시됨"
            
            return formatter.string(from: date)
        }
        return "-"
    }

}

