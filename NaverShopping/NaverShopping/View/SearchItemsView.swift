//
//  SearchItemsView.swift
//  UpDownGame
//
//  Created by 이상민 on 1/16/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchItemsView: BaseView{
    
    let sortOptionRelay = PublishRelay<sortOptions>()

    lazy var collectionView = createCollectionView()
    private let totalLabel = UILabel()
    private let accuracyBtn = SortButtonView(text: "정확도")
    private let dateBtn = SortButtonView(text: "날짜순")
    private let hightPrBtn = SortButtonView(text: "가격높은순")
    private let lowPrBtn = SortButtonView(text: "가격낮은순")
    private let scrollView = UIScrollView(frame: .zero)
    private lazy var stackView = UIStackView(arrangedSubviews: [accuracyBtn,dateBtn,hightPrBtn,lowPrBtn])
    
    var sortOption: sortOptions = .sim
    
//    weak var delegate: SearchItemsViewDelegate?
    
    private func createCollectionView() -> UICollectionView{
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(SearchItemCollectionViewCell.self, forCellWithReuseIdentifier: SearchItemCollectionViewCell.identifier)
        collectionView.collectionViewLayout = createCollectionViewLayout()
        return collectionView
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout{
        let padding = 12.0
        let spacing = 12.0
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = spacing
        let width = (UIScreen.main.bounds.width - (padding * 2) - (spacing)) / 2
        layout.itemSize = CGSize(width: width, height: 260)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(totalLabel)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        self.collectionView.backgroundColor = .black
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().offset(12)
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(12)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
    }
    
    override func configureView() {
        totalLabel.textColor = .systemGreen
        totalLabel.font = UIFont.systemFont(ofSize: 16)
        
        stackView.axis = .horizontal
        stackView.spacing = 12
        
        accuracyBtn.isSelected = true
        stackView.arrangedSubviews.forEach{ btnView in
            if let button = btnView as? SortButtonView{
                button.delegate = self
            }
        }
    }
    
    func setTotalDate(text: String){
        self.totalLabel.text = "\(text)개의 검색 결과"
    }
}

extension SearchItemsView: SortButtonDelegate{
    func sortButtonTapped(_ sender: SortButtonView) {
        stackView.arrangedSubviews.forEach{ view in
            if let button = view as? SortButtonView{
                button.isSelected = false
            }
        }
        sender.isSelected = true
        
        var newSortOption: sortOptions = .sim
        switch sender {
        case accuracyBtn:
            newSortOption = .sim
        case dateBtn:
            newSortOption = .date
        case hightPrBtn:
            newSortOption = .asc
        default:
            newSortOption = .dsc
        }
        
        self.sortOption = newSortOption
        sortOptionRelay.accept(newSortOption)
    }
}
