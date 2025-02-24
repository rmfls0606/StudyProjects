//
//  NewSearchViewController.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/24/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class NewSearchViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let viewModel = NewSearchViewModel()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .lightGray
        view.rowHeight = 180
        view.separatorStyle = .none
        return view
    }()
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
        configure()
        bind()
    }
    
    func bind(){
        //MARK: - Input
        let input = NewSearchViewModel.Input(searchTap: searchBar.rx.searchButtonClicked, searchText: searchBar.rx.text.orEmpty)
        
        //MARK: - Output
        let output = viewModel.transform(input: input)
        output.list
            .bind(
                to: tableView.rx
                    .items(
                        cellIdentifier: SearchTableViewCell.identifier,
                        cellType: SearchTableViewCell.self
                    )
            ){(row, element, cell) in
                cell.appNameLabel.text = element
            }
            .disposed(by: disposeBag)
        
        //        tableView.rx.itemSelected
        //            .map{ _ in
        //                Observable<Int>
        //                    .interval(.seconds(1), scheduler: MainScheduler.instance)
        //            }
        //            .subscribe(with: self) { owner, value in
        //                value
        //                    .subscribe { value in
        //                        print(value)
        //                    }
        //                    .disposed(by: owner.disposeBag)
        //            }
        //            .disposed(by: disposeBag)
        
        //        tableView.rx.itemSelected
        //            .withLatestFrom(
        //                Observable<Int>
        //                    .interval(.seconds(1), scheduler: MainScheduler.instance)
        //            )
        //            .subscribe(with: self) { owner, value in
        //                print(value)
        //            }
        //            .disposed(by: disposeBag)
        
        //map의 경우 subscribe를 한번 더 호출해 줬어야 했는데 flatMap은 한번만 해줘도 됨
        tableView.rx.itemSelected
            .flatMap{ _ in
                Observable<Int>
                    .interval(.seconds(1), scheduler: MainScheduler.instance)
            }
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
    }
    
    private func setSearchController() {
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}
