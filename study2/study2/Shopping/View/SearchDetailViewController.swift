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
    func didSelectSortOption(_ sortOptions: sortOptions)
}

final class SearchDetailViewController: UIViewController, SearchItemsViewDelegate {
    func didSelectSortOption(_ sortOptions: sortOptions) {
        self.start = 1
        callRequest(query: self.query!, start: 1, sortOption: sortOptions)
    }
    var query: String?
    
    let numberFormatter = NumberFormatter()
    
    private var start = 1
    private var isEnd = false
    
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
        view.backgroundColor = .red
        setUp()
        setBind()
        if let query = self.query{
            callRequest(query: query, start: self.start, sortOption: collectionview.sortOption)
        }
    }
    
    let viewModel = SearchDetailViewModel()
    
    private func setUp(){
        if let query = self.query{
            self.navigationItem.title = query
        }
        self.navigationController?.navigationBar.tintColor = .white
        self.view.backgroundColor = .black
        self.view.addSubview(collectionview)
        self.collectionview.delegate = self
        
        collectionview.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionview.configureDelegate(delegate: self, dataSource: self, prefetchDataSource: self)
    }
    
    private func setBind(){
        viewModel.outputSearchText.bind { text in
            self.navigationItem.title = text
        }
    }
    
    private func callRequest(query: String, start: Int, sortOption: sortOptions){
        
        let url = "https://openapi.naver.com/v1/search/shop.json?"

        let parameters: [String: Any] = [
            "query": self.query == "" ? self.query! : query,
            "start": start,
            "sort": sortOption.rawValue,
            "display": 30
        ]
        
        let headers: HTTPHeaders = HTTPHeaders([
            "X-Naver-Client-Id": cliendID,
            "X-Naver-Client-Secret": cliendSecret
        ])
        
        NetworkManager.shared.loadData(url: url,
                                       method: .get,
                                       parameters: parameters,
                                       headers: headers) { (result: Result<ItemList, Error>) in
            switch result{
            case .success(let data):
                print(data)
                if self.start == 1{
                    self.searchList = data.items
                }else{
                    self.searchList.append(contentsOf: data.items)
                }
                
                self.isEnd = self.searchList.count >= data.total
                
                let result = data.total.formatted(.number)
                self.collectionview.setTotalDate(text: result)
                self.collectionview.reloadData()
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            
        }
    }
}

extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchItemCollectionViewCell.identifier, for: indexPath) as? SearchItemCollectionViewCell else{
            return UICollectionViewCell()
        }
        let data = searchList[indexPath.item]
        cell.configureData(data: data)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.item == searchList.count - 1 && !isEnd{
//            self.start += 1
//            callRequest(query: self.query!, start: self.start)
//        }
//    }
}

extension SearchDetailViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        guard !isEnd else { return }

        for item in indexPaths{
            if searchList.count - 5 == item.item{
                self.start += 30
                callRequest(query: query!, start: self.start, sortOption: self.collectionview.sortOption)
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}
