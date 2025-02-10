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
    }
    
    struct Output{
        let searchResult: Observable<[SearchResult]> = Observable([])
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
    }
    
    private func callRequest(){
        guard let query = input.searchQuery.value, !query.isEmpty else {
            print("검색 에러")
            return
        }
        
        NetworkManager.shared.callRequest(api: .searchPhotos(query: query, page: 1, sort: .sortByRelevance)) { (response: SearchResponse, statusCode: Int) in
            
//            if self.page <= 1{
            self.output.searchResult.value = response.results
//            }else{
//                self.SearchData.append(contentsOf: response.results)
//            }
            
//            self.isEnd = page >= response.total_pages
//            self.searchResultView.reloadData()
            
//            self.showAlert(statusCode: statusCode)
        } failHandler: { [weak self] statusCode in
            print("ERROR Code : \(statusCode)")
//            self?.showAlert(statusCode: statusCode)
        }
    }
}
