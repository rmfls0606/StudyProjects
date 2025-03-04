//
//  SearchItemCollectionViewCell.swift
//  UpDownGame
//
//  Created by 이상민 on 1/15/25.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class SearchItemCollectionViewCell: BaseCollectionViewCell{
    
    let numberFormatter = NumberFormatter()
    var disposeBag = DisposeBag()
    static let identifier = "SearchItemCollectionViewCell"
    
    let itemImageView = UIImageView()
    let itemTitle = UILabel()
    let itemSubTitle = UILabel()
    let itemPrice = UILabel()
    let likeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        btn.tintColor = .systemPink
        return btn
    }()
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureHierarchy() {
        self.contentView.addSubview(itemImageView)
        self.contentView.addSubview(itemTitle)
        self.contentView.addSubview(itemSubTitle)
        self.contentView.addSubview(itemPrice)
        self.contentView.addSubview(likeButton)
    }
    
    override func configureLayout() {
        self.itemImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.contentView)
            make.width.equalTo(self.contentView.snp.width)
            make.height.equalTo(self.contentView.snp.width)
        }
        
        self.itemTitle.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        self.itemSubTitle.snp.makeConstraints { make in
            make.top.equalTo(itemTitle.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        self.itemPrice.snp.makeConstraints { make in
            make.top.equalTo(itemSubTitle.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.likeButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(itemImageView)
        }
    }
    
    override func configureView() {
        
        self.contentView.backgroundColor = .black
        
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.layer.cornerRadius = 10
        itemImageView.layer.masksToBounds = true
        
        itemTitle.font = UIFont.systemFont(ofSize: 12)
        itemTitle.textColor = .lightGray
        
        itemSubTitle.font = UIFont.systemFont(ofSize: 14)
        itemSubTitle.numberOfLines = 2
        itemSubTitle.textColor = .white
        
        itemPrice.font = .boldSystemFont(ofSize: 14)
        itemPrice.textColor = .white
    }
    
    func configureData(data: Item, isSelected: Bool){
        self.itemImageView.kf.setImage(with: URL(string: data.image))
        self.itemTitle.text = data.mallName
        self.itemSubTitle.text = data.title.htmlEscaped
        let result = Int(data.lprice)?.formatted(.number)
        self.itemPrice.text = result
        
        self.likeButton.isSelected = isSelected
    }
    
    func configureData2(data: LikeTable){
        self.itemImageView.kf.setImage(with: URL(string: data.imageNamge))
        self.itemTitle.text = data.productName
        self.itemSubTitle.text = data.productContent.htmlEscaped
        let result = Int(data.price)?.formatted(.number)
        self.itemPrice.text = result
        self.likeButton.isSelected = true
    }
}

//정규식으로 html태그 제거
extension String {
    var htmlEscaped: String {
        do {
            let regex = try NSRegularExpression(pattern: "<[^>]+>", options: .caseInsensitive)
            let range = NSRange(location: 0, length: self.utf16.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
        } catch {
            print("Regex error: \(error)")
            return self
        }
    }
}
