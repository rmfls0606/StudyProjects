//
//  SimpleCollectionViewController.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/26/25.
//

import UIKit
import SnapKit
/*
 Data
 -> Delegate, DataSource (가장 큰 특징: 인덱스 기반)
 -> Delegate, DiffableDataSource( list[itemPath.item]사용안함 -> 데이터 기반)
 list[indexPath.row]
 
 Layout
 -> FlowLayout
 ->
 -> List Configuration
 
 Presentation
 -> CellForRowAt / dequeueReusableCell
 ->
 -> List Cell / dequeueConfiguredReusbleCell
 */

struct Product: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let price = /*Int.random(in: 1...10000) * */1000
//    let count = Int.random(in: 1...10)
    let count = 8
}

class SimpleCollectionViewController: UIViewController {

    //huan error 빙지 차원에서
    enum Section: CaseIterable{ //케이스가 더 늘어날 것을 대비하기 위해 프로토콜 선언
        case main
        case sub
    }
    
    //Flow -> compositional -> List configuration
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    )
    
    //numberOfItemsInSection, cellforItemAt을 대신해준다.
    //<섹션을 구분해 줄 대이터 타입, 셀에 들어가는 데이터 타입>
    var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    //PRoduct confirm to Hashable
    
    
//    var list = [
//        "Hue", "Jack", "Bran", "Den"
//    ]
//    var list = [
//        1, 234, 555, 9006, 618
//    ]
    
    /*
     DiffableDataSource
     
     1. Hashable 해야한다.
     */
    
    var list = [
        Product(name: "Macbook Pro M5"),
        Product(name: "Macbook Pro M5"),
        Product(name: "트랙패드"),
        Product(name: "금")
    ]
    
    //테이블 뷰 시스템 기능을 컬렉션뷰로도 만들 수 있다.
    func createLayout() -> UICollectionViewLayout{
        
        var configuration = UICollectionLayoutListConfiguration(
            appearance: .insetGrouped
        )
        configuration.showsSeparators = false
        configuration.backgroundColor = .green
        
        let layout = UICollectionViewCompositionalLayout.list(
            using: configuration
        )
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        collectionView.delegate = self
//        collectionView.dataSource = self
        
//        configureCell()
        configureDataSource()
        updateSnapshot()
    }
    
    private func updateSnapshot(){
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([Product(name: "Jack")], toSection: .main)
        snapshot.appendItems(list, toSection: .main)
        snapshot.appendItems([Product(name: "고래밥")], toSection: .sub)
        
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource(){
        //collectionView.register 대신
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Product>!
        
        //cellForItemAt 내부 코드
        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            
            content.textProperties.font = .boldSystemFont(ofSize: 20)
            
            content.secondaryText = itemIdentifier.price.formatted() + "원"
            content.secondaryTextProperties.color = .blue
            
            content.image = UIImage(systemName: "star")
            content.imageProperties.tintColor = .orange
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .yellow
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2.0
            backgroundConfig.strokeColor = .red
            
            cell.backgroundConfiguration = backgroundConfig
        })
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                
                //Q. list[indexPath.item] ??
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: registration,
                    for: indexPath,
                    item: itemIdentifier
                )
            
                return cell
            }
        )
    }
    
//    private func configureCell(){
//        //cellForItemAt 내부 코드
//        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
//            
//            var content = UIListContentConfiguration.valueCell()
//            
//            content.text = itemIdentifier.name
//            content.textProperties.color = .brown
//            
//            content.textProperties.font = .boldSystemFont(ofSize: 20)
//            
//            content.secondaryText = itemIdentifier.price.formatted() + "원"
//            content.secondaryTextProperties.color = .blue
//            
//            content.image = UIImage(systemName: "star")
//            content.imageProperties.tintColor = .orange
//            
//            cell.contentConfiguration = content
//            
//            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
//            backgroundConfig.backgroundColor = .yellow
//            backgroundConfig.cornerRadius = 10
//            backgroundConfig.strokeWidth = 2.0
//            backgroundConfig.strokeColor = .red
//            
//            cell.backgroundConfiguration = backgroundConfig
//        })
//    }
}

extension SimpleCollectionViewController: UICollectionViewDelegate{
    //Q. 얘는 어디로 가는 거지?
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        list.count
//    }

    /*
     기존)
     dequeueReusableCell
     customCell + identifier + register
     
     New)
     dequeueConfiguredReusableCell
     systemCell +     x     + CellRegisteration
     */
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueConfiguredReusableCell(
//            using: registration,
//            for: indexPath,
//            item: list[indexPath.item]
//        )
//    
//        return cell
//    }

    
}
