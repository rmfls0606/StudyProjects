//
//  SearchDetailViewController.swift
//  UpDownGame
//
//  Created by 이상민 on 1/15/25.
//

import UIKit
import SnapKit
import Alamofire

protocol SearchItemsViewDelegate: AnyObject{
    func didSelectSortOption(_ sortOption: sortOptions)
}

final class SearchDetailViewController: UIViewController, SearchItemsViewDelegate {
    func didSelectSortOption(_ sortOption: sortOptions) {
        viewModel.inputSortOptionResult.value = sortOption
    }
    
    let numberFormatter = NumberFormatter()
    
    private var searchList = [Item]()
    
    private let cliendID = Bundle.main.infoDictionary?["XNaverClientId"] as! String
    private let cliendSecret = Bundle.main.infoDictionary?["XNaverClientSecret"] as! String
    
    private lazy var collectionview = SearchItemsView()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUp()
        setBind()
    }
    
    let viewModel = SearchDetailViewModel()
    
    private func setUp(){
        self.navigationController?.navigationBar.tintColor = .white
        self.view.backgroundColor = .black
        self.view.addSubview(collectionview)
        self.collectionview.delegate = self
        
        collectionview.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionview.configureDelegate(delegate: self, dataSource: self)
    }
    
    private func setBind(){
        viewModel.outputSearchText.bind { text in
            self.navigationItem.title = text
        }
        
        viewModel.outputItemList.bind { item in
            self.collectionview.reloadData()
        }
    }
}

extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.outputItemList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchItemCollectionViewCell.identifier, for: indexPath) as? SearchItemCollectionViewCell else{
            return UICollectionViewCell()
        }
        let data = self.viewModel.outputItemList.value[indexPath.item]
        cell.configureData(data: data)
        return cell
    }
}
