//
//  CompositionViewController.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/27/25.
//

import UIKit
import SnapKit

class CompositionViewController: UIViewController {
    
    enum Section: CaseIterable {
        case First
        case Second
    }
    
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
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    var list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1123, 434, 234, 5566, 654275]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureDataSource()
        updateSnapshot()
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
        var cellRegistraion = UICollectionView.CellRegistration<UICollectionViewListCell, Int> { cell, indexPath, itemIdentifier in
            
            print("CellRegistration", indexPath)
            
            var content = UIListContentConfiguration.subtitleCell()
            content.text = "\(itemIdentifier)"
            content.image = UIImage(systemName: "star")
            cell.contentConfiguration = content
        }
        
        //cellForItemAt
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: {
 collectionView,
                indexPath,
                itemIdentifier in
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistraion,
                    for: indexPath,
                    item: itemIdentifier
                )
                print("ReusableCell", indexPath)
                return cell
            }
        )
    }
    
    private func updateSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: .First)
        dataSource.apply(snapshot)
    }
}
