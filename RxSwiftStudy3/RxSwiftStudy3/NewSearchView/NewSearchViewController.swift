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
                cell.appNameLabel.text = element.movieNm
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
        //flatMapLatest의 경우 셀을 선택하면 타이머 시작되는데 다른 셀을 선택하면 과거의 실행되는 타이머는 사라진다. 즉 셀을 선택한 순간 새로 시작한다.
        tableView.rx.itemSelected
            .flatMapLatest{ _ in
                Observable<Int>
                    .interval(.seconds(1), scheduler: MainScheduler.instance)
                    .debug("timer")
            }
            .debug("cell")
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
