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
        configureDataSource()
    }
    
    private func configure(){
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func configureDataSource(){
        //cell register
        //cellForItemAt
        var cellRegistraion = UICollectionView.CellRegistration<UICollectionViewListCell, Int> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.subtitleCell()
            content.text = "\(itemIdentifier)"
            content.image = UIImage(systemName: "star")
            cell.contentConfiguration = content
        }
    }
}
