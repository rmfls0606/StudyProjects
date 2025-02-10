//
//  ResultDetailView.swift
//  study4
//
//  Created by 이상민 on 2/10/25.
//

import UIKit
import SnapKit

class ResultDetailView: BaseView {
    private var imageView: UIImageView = {
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
        self.addSubview(imageView)
        self.addSubview(boxView)
    }
    
    override func configureLayout() {
        self.imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.boxView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(12)
        }
//        imageView.kf.setImage(with: URL(string: item!.urls.small))
        
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
        self.imageView.kf.setImage(with: URL(string: searchResult.urls.small))
        self.sizeValueLabel.text = "\(searchResult.width) x \(searchResult.height)"
        self.viewsValueLabel.text = "\(resultStatistics.views.total)"
        self.downloadsValueLabel.text = "\(resultStatistics.downloads.total)"
    }
}
