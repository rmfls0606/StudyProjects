//
//  SearchResultViewModel.swift
//  study4
//
//  Created by 이상민 on 2/10/25.
//

import Foundation

class SearchResultViewModel: BaseViewModel{
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input{
        let searchQuery: Observable<String?> = Observable(nil)
        let searchResultFilterTapped: Observable<SortStatus> = Observable(.sortByRelevance)
    }
    
    struct Output{
        let searchResults: Observable<[SearchResult]> = Observable([])
        let searchResultFilterText: Observable<String?> = Observable(nil)
    }
    
    init(){
        input = Input()
        output = Output()
        
        transform()
    }
    
    deinit{ }
    
    func transform() {
        self.input.searchQuery.lazyBind { [weak self] text in
            self?.callRequest()
        }
        
        self.input.searchResultFilterTapped.lazyBind { [weak self] status in
            self?.callRequest()
            self?.output.searchResultFilterText.value = status.description
        }
    }
    
    private func callRequest(){
        guard let query = input.searchQuery.value, !query.isEmpty else {
            print("검색 에러")
            return
        }
        
        NetworkManager.shared.callRequest(api: .searchPhotos(query: query, page: 1, sort: input.searchResultFilterTapped.value)) { [weak self] (response: SearchResponse, statusCode: Int) in
            
//            if self.page <= 1{
            self?.output.searchResults.value = response.results
//            }else{
//                self.SearchData.append(contentsOf: response.results)
//            }
            
//            self.isEnd = page >= response.total_pages
//            self.searchResultView.reloadData()
            
//            self.showAlert(statusCode: statusCode)
        } failHandler: { [weak self] statusCode in
            print("ERROR Code : \(statusCode)")
        }
    }
}
