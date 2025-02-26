//
//  WishListViewController.swift
//  NaverShopping
//
//  Created by 이상민 on 2/26/25.
//

import UIKit
import SnapKit

struct Wish: Hashable{
    let name: String
    let date = Date()
}

class WishListViewController: BaseViewController {
    private var dateFormatter: DateFormatter{
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatted
    }
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "위시리스트"
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = UIColor(named: "searchBarbc")
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: searchBar.placeholder!, attributes: [.foregroundColor: UIColor.lightGray])
        searchBar.searchTextField.textColor = .lightGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        return searchBar
    }()
    
    //numberOfItemsInSection, cellforItemAt을 대신해준다.
    var dataSource: UICollectionViewDiffableDataSource<String, Wish>!
    
//    var list = ["킁킁", "냄새", "향기"] //임시 데이터
    var list = [
        Wish(name: "킁킁"),
        Wish(name: "냄세"),
        Wish(name: "형기")
    ]
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    )
    
    private func createLayout() -> UICollectionViewLayout {
        var configuraion = UICollectionLayoutListConfiguration(
            appearance: .plain
        )
        
        configuraion.backgroundColor = .black
        let layout = UICollectionViewCompositionalLayout.list(
            using: configuraion
        )
        
        return layout
    }
    
    override func configureHierarchy() {
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        self.searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        self.view.backgroundColor = .black
        self.title = "위시리스트"
        
        self.collectionView.delegate = self
        
//        configureCell()
        configureDataSource()
        updateSnapshot()
    }
    
    private func updateSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<String, Wish>()
        snapshot.appendSections(["위시리스트"])
        snapshot.appendItems(list, toSection: "위시리스트")
        
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource(){
        //collectionView.register을 대신하는 코드
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Wish>!
        
        //cellForItemAt 내부 코드
        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            content.textProperties.font = .boldSystemFont(ofSize: 20)
            
            content.secondaryText = self.dateFormatter
                .string(from: itemIdentifier.date)
            content.secondaryTextProperties.color = .gray
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listCell()
            backgroundConfig.backgroundColor = .yellow
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2.0
            backgroundConfig.strokeColor = .red
            
            cell.backgroundConfiguration = backgroundConfig
        })
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: {
 collectionView,
                indexPath,
                itemIdentifier in
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: registration,
                    for: indexPath,
                    item: itemIdentifier
                )
                return cell
            }
        )
    }
    
//    private func configureCell(){
//        //cellForItemAt 내부 코드
//        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
//            
//            var content = UIListContentConfiguration.valueCell()
//            
//            content.text = itemIdentifier.name
//            content.textProperties.color = .brown
//            content.textProperties.font = .boldSystemFont(ofSize: 20)
//            
//            cell.contentConfiguration = content
//            
//            var backgroundConfig = UIBackgroundConfiguration.listCell()
//            backgroundConfig.backgroundColor = .yellow
//            backgroundConfig.cornerRadius = 10
//            backgroundConfig.strokeWidth = 2.0
//            backgroundConfig.strokeColor = .red
//            
//            cell.backgroundConfiguration = backgroundConfig
//        })
//    }
}

//MARK: - CollectionView
extension WishListViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        list.count
//    }

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueConfiguredReusableCell(
//            using: registration,
//            for: indexPath,
//            item: list[indexPath.item]
//        )
//        
//        cell.backgroundColor = .orange
//        
//        return cell
//    }
//
    
}
