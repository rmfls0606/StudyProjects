//
//  HomeworkViewController.swift
//  RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let profileImage: String
}

class HomeworkViewController: UIViewController {
    
    let tableView = UITableView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    let searchBar = UISearchBar()
    
    let disposeBag = DisposeBag()
    
    let viewModel = HomeworkViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
     
    private func bind() {
        let recentText = PublishSubject<String>()
        
        let input = HomeworkViewModel.Input(
            searchButtonTap: searchBar.rx.searchButtonClicked,
            searchText: searchBar.rx.text.orEmpty,
            recentText: recentText
        )
        let output = viewModel.transform(input: input)
        
        //MARK: - TableView -> Show
        output.items
            .asDriver(onErrorJustReturn: [])
            .drive(
                tableView.rx
                    .items(
                        cellIdentifier: PersonTableViewCell.identifier,
                        cellType: PersonTableViewCell.self)
            ){ (row, element, cell) in
                cell.usernameLabel.text = element
            }
            .disposed(by: disposeBag)
        
        //MARK: - collectionView -> show
        output.recent
            .asDriver() // 위의 subject의 경우는 .asDriver()를 사용할 수 없었던 이유: subject의 경우  onNext, onCompleted, OnError로 방출할 수 있다보니 에러가 발생할 경우 처리해주는 코드가 필요, relay의 경우 accept만 사용하여 방출하기 떄문에 에러처리를 해줄 필요가 없다.
            .drive(
                collectionView.rx
                    .items(
                        cellIdentifier: UserCollectionViewCell.identifier,
                        cellType: UserCollectionViewCell.self
                    )
            ){ (row, element, cell) in
                cell.label.text = element
            }
            .disposed(by: disposeBag)
        
        Observable
            .zip(
                tableView.rx.modelSelected(String.self),
                tableView.rx.itemSelected
            )
            .map{ $0.0 }
            .bind(with: self) { owner, text in
                print(text)
                recentText.onNext(text)
            }
            .disposed(by: disposeBag)
        
        
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
         
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }

}
 
