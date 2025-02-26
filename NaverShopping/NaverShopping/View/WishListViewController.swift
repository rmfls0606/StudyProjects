//
//  WishListViewController.swift
//  NaverShopping
//
//  Created by 이상민 on 2/26/25.
//

import UIKit
import SnapKit

class WishListViewController: BaseViewController {
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
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    )
    
    private func createLayout() -> UICollectionViewLayout {
        var configuraion = UICollectionLayoutListConfiguration(
            appearance: .plain
        )
        
        let layout = UICollectionViewCompositionalLayout.list(
            using: configuraion
        )
        
        return layout
    }
    
    override func configureHierarchy() {
        self.view.addSubview(searchBar)
    }
    
    override func configureLayout() {
        self.searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        self.view.backgroundColor = .black
        self.title = "위시리스트"
    }
}
