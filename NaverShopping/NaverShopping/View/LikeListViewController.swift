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

class LikeListViewController: BaseViewController {
    
    private lazy var collectionView = createCollectionView()
    private let disposeBag = DisposeBag()
    
    private func createCollectionView() -> UICollectionView{
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(SearchItemCollectionViewCell.self, forCellWithReuseIdentifier: SearchItemCollectionViewCell.identifier)
        collectionView.collectionViewLayout = createCollectionViewLayout()
        return collectionView
    }
    
    var array = Observable.just([1,2,3]) //testData
    
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
        
    }
    
    override func configureBind() {
        
        array
            .bind(
                to: collectionView.rx
                    .items(
                        cellIdentifier: SearchItemCollectionViewCell.identifier,
                        cellType: SearchItemCollectionViewCell.self
                    )
            ){ (row, element, cell) in
                
            }
            .disposed(by: disposeBag)
    }
}
