//
//  SearchPhotoViewController.swift
//  PhotoSearchAPI
//
//  Created by 이상민 on 1/19/25.
//

import UIKit
import SnapKit
import Alamofire

final class SearchPhotoViewController: UIViewController{
    private lazy var searchResultView = SearchResultView()
    
    private var SearchData = [SearchResult]()
    private var query = ""
    private var sortState: SortStatus = SortStatus.sortByRelevance
    private var page = 1
    private var isEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setLogic()
    }
    
    private func setUI(){
        self.view.addSubview(searchResultView)
    }
    
    private func setLayout(){
        self.searchResultView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setLogic(){
        self.navigationItem.title = "SEARCH PHOTO"
        self.view.backgroundColor = .white
        
        searchResultView.configureSearchBarDelegate(delegate: self)
        searchResultView.configureCollectionDelegate(delegate: self, dataSource: self, prefetchDataSource: self)
    }
    
    
    private func callRequest(query: String, page: Int, sort: SortStatus){
        NetworkManager.shared.callRequest(api: .searchPhotos(query: query, page: page, sort: sort)) { (response: SearchResponse, statusCode: Int) in
            
            if self.page <= 1{
                self.SearchData = response.results
            }else{
                self.SearchData.append(contentsOf: response.results)
            }
            
            self.isEnd = page >= response.total_pages
            self.searchResultView.reloadData()
            
            self.showAlert(statusCode: statusCode)
        } failHandler: { [weak self] statusCode in
            self?.showAlert(statusCode: statusCode)
        }
    }
}

extension SearchPhotoViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        guard let query = searchBar.text else{
            print("검색 에러")
            return
        }
        self.query = query
        self.page = 1
        callRequest(query: query, page: 1, sort: sortState)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
}

extension SearchPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        SearchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionCell.identifier, for: indexPath) as? SearchResultCollectionCell else{
            return UICollectionViewCell()
        }
        let data = SearchData[indexPath.item]
        cell.configureData(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let nextVC = DetailViewController()
//        nextVC.item = self.SearchData[indexPath.item]
//        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchPhotoViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard !isEnd else { return }
        
        for item in indexPaths{
            if SearchData.count - 5 <= item.item{
                self.page += 1
                callRequest(query: query, page: self.page, sort: sortState)
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}
