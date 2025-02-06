//
//  SearchItemsView.swift
//  UpDownGame
//
//  Created by 이상민 on 1/16/25.
//

import UIKit
import SnapKit

enum sortOptions: String{
    case sim = "sim"
    case date = "date"
    case asc = "asc"
    case dsc = "dsc"
}

final class SearchItemsView: BaseView{
    private(set) lazy var collectionView = createCollectionView()
    private lazy var totalLabel = UILabel()
    private lazy var accuracyBtn = SortButtonView(text: "정확도")
    private lazy var dateBtn = SortButtonView(text: "날짜순")
    private lazy var hightPrBtn = SortButtonView(text: "가격높은순")
    private lazy var lowPrBtn = SortButtonView(text: "가격낮은순")
    private lazy var scrollView = UIScrollView(frame: .zero)
    private lazy var stackView = UIStackView(arrangedSubviews: [accuracyBtn,dateBtn,hightPrBtn,lowPrBtn])
    private(set) var sortOption: sortOptions = .sim
    
    weak var delegate: SearchItemsViewDelegate?
    
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
    
    func configureDelegate(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource, prefetchDataSource: UICollectionViewDataSourcePrefetching){
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
        self.collectionView.prefetchDataSource = prefetchDataSource
    }
    
    func reloadData(){
        self.collectionView.reloadData()
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
        
        switch sender {
        case accuracyBtn:
            self.sortOption = .sim
        case dateBtn:
            self.sortOption = .date
        case hightPrBtn:
            self.sortOption = .asc
        default:
            self.sortOption = .dsc
        }
        
        delegate?.didSelectSortOption(self.sortOption)
    }
}
