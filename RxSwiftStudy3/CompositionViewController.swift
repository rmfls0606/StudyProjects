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
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //,fraction: 비율, .absolute: 고정
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50.0)
        )
        let group = NSCollectionLayoutGroup
            .horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
//    func createLayout() -> UICollectionViewLayout{
//        
//        var configuration = UICollectionLayoutListConfiguration(
//            appearance: .insetGrouped
//        )
//        configuration.backgroundColor = .purple
//        configuration.showsSeparators = true
////        configuration.leadingSwipeActionsConfigurationProvider
//        
//        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
//        
//        return layout
//    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    var list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1123, 434, 234, 5566, 654275]
    var list2 = [1, 2, 3, 4, 5566, 654275]
    
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
        let cellRegistraion = UICollectionView.CellRegistration<CompositionCollectionViewCell, Int> { cell, indexPath, itemIdentifier in
            
            print("CellRegistration", indexPath)
            
            cell.label.text = "\(indexPath)"
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
        snapshot.appendItems(list2, toSection: .Second)
        dataSource.apply(snapshot)
    }
}
