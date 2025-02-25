//
//  SearchViewController.swift
//  NaverShopping
//
//  Created by 이상민 on 2/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    let numberFormatter = NumberFormatter()
    
    private let viewModel: SearchViewModel
    private let disposeBag = DisposeBag()
    
    private let searchItemsView = SearchItemsView()
    
    init(query: String){
        self.viewModel = SearchViewModel(query: query)
        super.init(nibName: nil, bundle: nil)
        self.title = query
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        self.view.addSubview(searchItemsView)
    }
    
    override func configureLayout() {
        searchItemsView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        self.view.backgroundColor = .black
    }
    
    override func configureBind() {
        let input = SearchViewModel.Input(searchTrigger: Observable<Void>.just(()),
                                          sortOption: searchItemsView.sortOptionRelay.asObservable())
        let output = viewModel.tranform(input: input)
        
        output.items
            .bind(to: searchItemsView.collectionView.rx.items(
                cellIdentifier: SearchItemCollectionViewCell.identifier,
                cellType: SearchItemCollectionViewCell.self)
            ) { (row, element, cell) in
                print(element)
                cell.configureData(data: element)
            }
            .disposed(by: disposeBag)
        
        print(output.items.values)
    }
}
