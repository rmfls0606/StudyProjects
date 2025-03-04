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
    
    private lazy var collectionView = createCollectionView()
    private let disposeBag = DisposeBag()
    
    var list: Results<LikeTable>!
    
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
    
    override func configureHierarchy() {
        self.view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        self.collectionView.snp.makeConstraints { make in
            make.top.leading.trailing
                .equalTo(self.view.safeAreaLayoutGuide)
                .inset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        list = realm.objects(LikeTable.self)
        self.collectionView.backgroundColor = .black
    }
    
    override func configureBind() {
        
        Observable.just(list)
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
            }
            .disposed(by: disposeBag)
    }
}
