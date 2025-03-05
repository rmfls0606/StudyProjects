//
//  MainViewController.swift
//  NaverShopping
//
//  Created by 이상민 on 2/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
    
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = UIColor(named: "searchBarbc")
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: searchBar.placeholder!, attributes: [.foregroundColor: UIColor.lightGray])
        searchBar.searchTextField.textColor = .lightGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        return searchBar
    }()
    
    override func configureHierarchy() {
        self.view.addSubview(searchBar)
    }
    
    override func configureLayout() {
        self.searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    override func configureView() {
        self.view.backgroundColor = .black
        self.navigationItem.title = "도봉러의 쇼핑쇼핑"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "list.bullet.circle.fill"),
            style: .plain,
            target: self,
            action: nil
        )
        
        let leftButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: nil
        )
        
        rightBarButton.tintColor = .white
        leftButton.tintColor = .systemPink
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    override func configureBind() {
        let input = MainViewModel.Input(
            searchReturn: searchBar.rx.searchButtonClicked,
            searchText: searchBar.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input: input)
        
        output.query
            .subscribe(
                with: self) {
                    owner,
                    value in
                    let nextVC = SearchViewController(query: value)
                    owner.navigationController?
                        .pushViewController(
                            nextVC,
                            animated: true
                        )
                }
                .disposed(by: disposeBag)
        
        self.navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                let nextVC = WishFolderViewController()
                owner.navigationController?
                    .pushViewController(nextVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        self.navigationItem.leftBarButtonItem?.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                let nextVC = LikeListViewController()
                owner.navigationController?
                    .pushViewController(nextVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
