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
import RealmSwift

final class SearchViewController: BaseViewController {
    
    let numberFormatter = NumberFormatter()
    
    let realm = try! Realm()
    
    private let viewModel: SearchViewModel
    private let disposeBag = DisposeBag()
    
    private let searchItemsView = SearchItemsView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchItemsView.collectionView.reloadData()
    }
    
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
        print(realm.configuration.fileURL)
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
                cell
                    .configureData(
                        data: element,
                        isSelected: self.realm
                            .objects(LikeTable.self)
                            .contains{$0.id == element.productId}
                    )
                cell.likeButton.rx.tap
                    .subscribe(with: self) {
 owner,
 _ in
                        if cell.likeButton.isSelected{
                            cell.likeButton.isSelected.toggle()
                            do{
                                try owner.realm.write {
                                    let data = owner.realm.objects(
                                        LikeTable.self
                                    ).where { $0.id == element.productId
                                    }
                                    owner.realm.delete(data)
                                }
                                owner.searchItemsView.collectionView.reloadData()
                            }catch{
                                print("삭제 실패")
                            }
                        }else{
                            cell.likeButton.isSelected.toggle()
                            do{
                                try owner.realm.write {
                                    let data = LikeTable(
                                        id: element.productId,
                                        imageNamge: element.image,
                                        productName: element.mallName,
                                        productContent: element.title,
                                        price: element.lprice
                                    )
                                    
                                    owner.realm.add(data)
                                }
                            }catch{
                                print("삽입 실패")
                            }
                        }
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        print(output.items.values)
    }
}
