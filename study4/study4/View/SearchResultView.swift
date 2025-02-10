//
//  SearchResultView.swift
//  PhotoSearchAPI
//
//  Created by 이상민 on 1/19/25.
//

import UIKit
import SnapKit

final class SearchResultView: BaseView{
    
    var onButtonTapped: (() -> Void)?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "키워드 검색"
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: searchBar.placeholder!, attributes: [.foregroundColor: UIColor.lightGray])
        searchBar.searchTextField.textColor = .lightGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        return searchBar
    }()
    
    private lazy var toggleButton: UIButton = {
        let button = UIButton(configuration: .filled())
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.cornerStyle = .capsule
        config.background.strokeColor = .gray
        config.background.strokeWidth = 1.0
        
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        var title = AttributedString("관련순")
        title.font = UIFont.systemFont(ofSize: 16)
        config.attributedTitle = title
        
        button.configuration = config
        
        button.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var collectionView = createCollectionView()
    
    private func createCollectionView() -> UICollectionView{
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(SearchResultCollectionCell.self, forCellWithReuseIdentifier: SearchResultCollectionCell.identifier)
        collectionView.collectionViewLayout = createCollectionViewLayout()
        return collectionView
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        let width = (UIScreen.main.bounds.width - 10) / 2
        layout.itemSize = CGSize(width: width, height: width * 1.6)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    override func configureHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(collectionView)
        self.addSubview(toggleButton)
    }
    
    override func configureLayout() {
        self.searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.toggleButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.trailing.equalToSuperview().inset(12)
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(toggleButton.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureSearchBarDelegate(delegate: UISearchBarDelegate){
        self.searchBar.delegate = delegate
    }
    
    func configureCollectionDelegate(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource, prefetchDataSource: UICollectionViewDataSourcePrefetching){
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
        self.collectionView.prefetchDataSource = prefetchDataSource
    }
    
    func reloadData(){
        self.collectionView.reloadData()
    }
    
    func configureToggleButtonText(text: String){
        self.toggleButton.setTitle(text, for: .normal)
    }
    
    //MARK: - Actions
    @objc
    private func toggleButtonTapped(){
        self.onButtonTapped?()
    }
}
