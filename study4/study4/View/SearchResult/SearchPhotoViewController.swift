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
    
    let viewModel = SearchResultViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setLogic()
        setBind()
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
        searchResultView.onButtonTapped = self.filterButtonTapped
    }
    
    private func setBind(){
        viewModel.output.searchResults.lazyBind { [weak self] _ in
            self?.searchResultView.reloadData()
        }
        
        viewModel.output.searchResultFilterText.lazyBind { [weak self] text in
            self?.searchResultView.configureToggleButtonText(text: text!)
        }
    }
    
    private func filterButtonTapped(){
        viewModel.input.searchResultFilterTapped.value.toggle()
    }
}

extension SearchPhotoViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        viewModel.input.searchQuery.value = searchBar.text
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
        self.viewModel.output.searchResults.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionCell.identifier, for: indexPath) as? SearchResultCollectionCell else{
            return UICollectionViewCell()
        }
        let data = self.viewModel.output.searchResults.value[indexPath.item]
        cell.configureData(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        nextVC.viewModel.output.searchResult.value = self.viewModel.output.searchResults.value[indexPath.item]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchPhotoViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard !viewModel.output.isLoading.value else { return }
        
        for item in indexPaths{
            if viewModel.output.searchResults.value.count - 5 <= item.item{
                self.viewModel.input.searchResultPage.value += 1
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}
