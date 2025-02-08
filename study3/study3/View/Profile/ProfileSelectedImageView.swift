//
//  ProfileSelectedImageView.swift
//  study3
//
//  Created by 이상민 on 2/9/25.
//

import UIKit
import SnapKit

class ProfileSelectedImageView: BaseView {
    private lazy var collectionView = createCollectionView()
    
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.collectionViewLayout = createCollectionViewLayout()
        return collectionView
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let padding = 12.0
        let spacing = 10.0
        let width = (UIScreen.main.bounds.width - (padding * 2) - (spacing * 3)) / 4
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }
    
    override func configureHierarchy() {
        self.addSubview(collectionView)
    }
    
    override func configureLayout() {
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
