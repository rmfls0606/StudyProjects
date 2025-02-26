//
//  SimpleCollectionViewController.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/26/25.
//

import UIKit
/*
 Data
 -> Delegate, DataSource (가장 큰 특징: 인덱스 기반)
 list[indexPath.row]
 
 Layout
 -> FlowLayout
 ->
 -> List Configuration
 
 Presentation
 -> CellForRowAt / dequeueReusableCell
 ->
 -> List Cell
 */
class SimpleCollectionViewController: UIViewController {

    //Flow -> compositional -> List configuration
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    )
    
    //테이블 뷰 시스템 기능을 컬렉션뷰로도 만들 수 있다.
    func createLayout() -> UICollectionViewLayout{
        
        var configuration = UICollectionLayoutListConfiguration(
            appearance: .insetGrouped
        )
        
        let layout = UICollectionViewCompositionalLayout.list(
            using: configuration
        )
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
