//
//  SearchResultCollectionCell.swift
//  PhotoSearchAPI
//
//  Created by 이상민 on 1/19/25.
//

import Foundation

import UIKit
import SnapKit
import Kingfisher


final class SearchResultCollectionCell: BaseCollectionViewCell{
    
    static let identifier = "SearchResultCollectionCell"
    
    private lazy var itemImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var starButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        
        var config = UIButton.Configuration.bordered()
        config.baseBackgroundColor = .darkGray
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        config.background.strokeColor = .darkGray
        config.background.strokeWidth = 1.0
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        config.imagePadding = 5
        
        let smallImage = UIImage.SymbolConfiguration(pointSize: 8)
        let image = UIImage(systemName: "star.fill", withConfiguration: smallImage)?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        
        var title = AttributedString("11")
        title.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        config.attributedTitle = title
        config.titleAlignment = .center
        
        button.configuration = config
        
        return button
    }()
    
    override func configureHierarchy() {
        self.addSubview(itemImageView)
        self.addSubview(starButton)
    }
    
    override func configureLayout() {
        self.itemImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.starButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configureData(data: SearchResult){
        self.itemImageView.kf.setImage(with: URL(string: data.urls.small))
    }
}
