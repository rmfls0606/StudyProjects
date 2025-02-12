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
        let searchResultPage: Observable<Int> = Observable(1)
    }
    
    struct Output{
        let searchResults: Observable<[SearchResult]> = Observable([])
        let searchResultFilterText: Observable<String?> = Observable(nil)
        let isLoading: Observable<Bool> = Observable(false)
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
            self?.resetPage()
            self?.callRequest()
            self?.output.searchResultFilterText.value = status.description
        }
        
        self.input.searchResultPage.lazyBind { [weak self] page in
            self?.callRequest()
        }
    }
    
    private func callRequest(){
        guard let query = input.searchQuery.value, !query.isEmpty else {
            print("검색 에러")
            return
        }
        
        NetworkManager.shared.callRequest(api: .searchPhotos(query: query, page: input.searchResultPage.value, sort: input.searchResultFilterTapped.value)) { [weak self] (response: SearchResponse, statusCode: Int) in
            
            guard let page = self?.input.searchResultPage.value else { return }
            
            if page <= 1{
                self?.output.searchResults.value = response.results
            }else{
                var newData = self?.output.searchResults.value ?? []
                newData.append(contentsOf: response.results)
                self?.output.searchResults.value = newData
            }
            
            if page >= response.total_pages || response.results.isEmpty {
                self?.output.isLoading.value = true
            }
        } failHandler: { [weak self] statusCode in
            print("ERROR Code : \(statusCode)")
        }
    }
    
    private func resetPage(){
        input.searchResultPage.value = 1
        output.isLoading.value = false
        output.searchResults.value = []
    }
}
