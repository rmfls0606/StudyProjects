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
import Kingfisher

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let profileImage: String
}

class HomeworkViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    let searchBar = UISearchBar()
    
    let viewModel = HomeworkViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
     
    private func bind() {
        let input = HomeworkViewModel.Input(searchText: searchBar.rx.text.orEmpty, searchClick: searchBar.rx.searchButtonClicked, tableViewCellSelected: tableView.rx.modelSelected(Person.self))
        
        let output = viewModel.transform(input: input)
        
        //MARK: - 데이터를 이용하여 테이블 뷰 셀 보여주기
        output.tableViewItems
            .bind(to: tableView.rx.items(cellIdentifier: PersonTableViewCell.identifier, cellType: PersonTableViewCell.self)){ (row, element, cell) in
                cell.usernameLabel.text = element.name
                cell.profileImageView.kf
                    .setImage(with: URL(string: element.profileImage))
                cell.detailButton.rx.tap.bind(with: self) { owner, _ in
                    let nextVC = DetailViewController()
                    nextVC.navigationItem.title = element.name
                    owner.navigationController?.pushViewController(nextVC, animated: true)
                }
                .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        output.collectionViewItems
            .bind(to: collectionView.rx.items( cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self)){ (item, element, cell) in
                cell.label.text = element
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
 
