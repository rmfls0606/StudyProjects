//
//  CompositionViewController.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/27/25.
//

import UIKit
import SnapKit

class CompositionViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    )
    
    func createLayout() -> UICollectionViewLayout{
        
        var configuration = UICollectionLayoutListConfiguration(
            appearance: .insetGrouped
        )
        configuration.backgroundColor = .purple
        configuration.showsSeparators = true
//        configuration.leadingSwipeActionsConfigurationProvider
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure(){
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
