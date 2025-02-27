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
    
    //MARK: - SectionProvider
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0{
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1/3)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 5,
                    leading: 5,
                    bottom: 5,
                    trailing: 5
                )//cell 내부 간격
                
                let innerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(1)
                )
                
                let innerGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: innerSize,
                    subitems: [item]
                )
                
                //,fraction: 비율, .absolute: 고정
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(300.0),
                    heightDimension: .absolute(100.0)
                )
                
                let group = NSCollectionLayoutGroup
                    .horizontal(layoutSize: groupSize, subitems: [innerGroup])
                
                let section = NSCollectionLayoutSection(group: group)
                //        section.interGroupSpacing = 20 //행사이의 간격
                
                /*section.orthogonalScrollingBehavior = .continuous*/ //group에 관한 수평 스크롤
                /*section.orthogonalScrollingBehavior = .paging*/ //group에 관한 수평 스크롤
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            }else{
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(1.0)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 5,
                    leading: 5,
                    bottom: 5,
                    trailing: 5
                )//cell 내부 간격
                
                //,fraction: 비율, .absolute: 고정
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(100.0)
                )
                
                let group = NSCollectionLayoutGroup
                    .horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                //        section.interGroupSpacing = 20 //행사이의 간격
                return section
            }
        }
        return layout
    }
    
    //    //MARK: - 앱스토어 처럼 수평 수직 스크롤, 수직에는 몇개가 쌓여있게
    //    func createLayout() -> UICollectionViewLayout {
    //        let itemSize = NSCollectionLayoutSize(
    //            widthDimension: .fractionalWidth(1.0),
    //            heightDimension: .fractionalHeight(1/3)
    //        )
    //
    //        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //        item.contentInsets = NSDirectionalEdgeInsets(
    //            top: 5,
    //            leading: 5,
    //            bottom: 5,
    //            trailing: 5
    //        )//cell 내부 간격
    //
    //        let innerSize = NSCollectionLayoutSize(
    //            widthDimension: .fractionalWidth(1/3),
    //            heightDimension: .fractionalHeight(1)
    //        )
    //
    //        let innerGroup = NSCollectionLayoutGroup.vertical(
    //            layoutSize: innerSize,
    //            subitems: [item]
    //        )
    //
    //        //,fraction: 비율, .absolute: 고정
    //        let groupSize = NSCollectionLayoutSize(
    //            widthDimension: .absolute(300.0),
    //            heightDimension: .absolute(100.0)
    //        )
    //
    //        let group = NSCollectionLayoutGroup
    //            .horizontal(layoutSize: groupSize, subitems: [innerGroup])
    //
    //        let section = NSCollectionLayoutSection(group: group)
    //        //        section.interGroupSpacing = 20 //행사이의 간격
    //
    //        /*section.orthogonalScrollingBehavior = .continuous*/ //group에 관한 수평 스크롤
    //        /*section.orthogonalScrollingBehavior = .paging*/ //group에 관한 수평 스크롤
    //        section.orthogonalScrollingBehavior = .groupPaging
    //
    //        let layout = UICollectionViewCompositionalLayout(section: section)
    //
    //        return layout
    //    }
    
    //MARK: - 3
    //    //수평
    //    func createLayout() -> UICollectionViewLayout {
    //        let itemSize = NSCollectionLayoutSize(
    //            widthDimension: .fractionalWidth(1.0),
    //            heightDimension: .fractionalHeight(1.0)
    //        )
    //
    //        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //        item.contentInsets = NSDirectionalEdgeInsets(
    //            top: 5,
    //            leading: 5,
    //            bottom: 5,
    //            trailing: 5
    //        )//cell 내부 간격
    //
    //        //,fraction: 비율, .absolute: 고정
    //        let groupSize = NSCollectionLayoutSize(
    //            widthDimension: .absolute(300.0),
    //            heightDimension: .absolute(100.0)
    //        )
    //
    //        let group = NSCollectionLayoutGroup
    //            .horizontal(layoutSize: groupSize, subitems: [item])
    //
    //        let section = NSCollectionLayoutSection(group: group)
    //        //        section.interGroupSpacing = 20 //행사이의 간격
    //
    //        /*section.orthogonalScrollingBehavior = .continuous*/ //group에 관한 수평 스크롤
    //        section.orthogonalScrollingBehavior = .groupPaging
    //
    //        let layout = UICollectionViewCompositionalLayout(section: section)
    //
    //        return layout
    //    }
    
    //MARK: - 2
    //    func createLayout() -> UICollectionViewLayout{
    //        let itemSize = NSCollectionLayoutSize(
    //            widthDimension: .fractionalWidth(1/3),
    //            heightDimension: .fractionalHeight(1.0)
    //        )
    //
    //        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //        item.contentInsets = NSDirectionalEdgeInsets(
    //            top: 5,
    //            leading: 5,
    //            bottom: 5,
    //            trailing: 5
    //        )//cell 내부 간격
    //
    //        //,fraction: 비율, .absolute: 고정
    //        let groupSize = NSCollectionLayoutSize(
    //            widthDimension: .fractionalWidth(1.0),
    //            heightDimension: .absolute(100.0)
    //        )
    //
    //        let group = NSCollectionLayoutGroup
    //            .horizontal(layoutSize: groupSize, subitems: [item])
    //
    //        let section = NSCollectionLayoutSection(group: group)
    ////        section.interGroupSpacing = 20 //행사이의 간격
    //
    //        let layout = UICollectionViewCompositionalLayout(section: section)
    //
    //        return layout
    //    }
    
    
    //MARK: - 1
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
