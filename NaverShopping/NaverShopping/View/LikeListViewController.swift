//
//  LikeListViewController.swift
//  NaverShopping
//
//  Created by 이상민 on 3/4/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RealmSwift

class LikeListViewController: BaseViewController {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "좋아요 리스트 검색"
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = UIColor(named: "searchBarbc")
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: searchBar.placeholder!, attributes: [.foregroundColor: UIColor.lightGray])
        searchBar.searchTextField.textColor = .lightGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        return searchBar
    }()
    private lazy var collectionView = createCollectionView()
    private let disposeBag = DisposeBag()
    
    //    var list: Results<LikeTable>!
    private let likeListSubject = BehaviorSubject<[LikeTable]>(value: [])
    
    let realm = try! Realm()
    
    private func createCollectionView() -> UICollectionView{
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(SearchItemCollectionViewCell.self, forCellWithReuseIdentifier: SearchItemCollectionViewCell.identifier)
        collectionView.collectionViewLayout = createCollectionViewLayout()
        return collectionView
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout{
        let padding = 12.0
        let spacing = 12.0
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = spacing
        let width = (UIScreen.main.bounds.width - (padding * 2) - (spacing)) / 2
        layout.itemSize = CGSize(width: width, height: 260)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadData()
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
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing
                .equalTo(self.view.safeAreaLayoutGuide)
                .inset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        self.collectionView.backgroundColor = .black
        reloadData()
    }
    
    func reloadData(){
        let results = realm.objects(LikeTable.self)
        let array = Array(results)
        likeListSubject.onNext(array)
    }
    
    override func configureBind() {
        
        likeListSubject
            .bind(
                to: collectionView.rx
                    .items(
                        cellIdentifier: SearchItemCollectionViewCell.identifier,
                        cellType: SearchItemCollectionViewCell.self
                    )
            ){ (row, element, cell) in
                print(element.id)
                let data = element
                cell.configureData2(data: data)
                cell.likeButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        do{
                            try owner.realm.write {
                                owner.realm.delete(element)
                            }
                        }catch{
                            print("삭제 실패")
                        }
                        owner.reloadData()
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .subscribe(with: self) { (owner, text) in
                let filtered: [LikeTable]
                if text.isEmpty{
                    filtered = Array(owner.realm.objects(LikeTable.self))
                }else{
                    filtered = Array(owner.realm.objects(LikeTable.self).filter{ $0.productName.contains(text) || $0.productContent.contains(text)})
                }
                owner.likeListSubject.onNext(filtered)
                owner.searchBar.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
    }
}
