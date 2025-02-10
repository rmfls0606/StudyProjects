//
//  ResultDetailViewModel.swift
//  study4
//
//  Created by 이상민 on 2/10/25.
//

import Foundation

class ResultDetailViewModel: BaseViewModel{
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input{
        
    }
    
    struct Output{
        let searchResult: Observable<SearchResult?> = Observable(nil)
        let resultStatistics: Observable<StatisticsResponse?> = Observable(nil)
    }
    
    init(){
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        output.searchResult.bind { [weak self] result in
            self?.callRequest()
        }
    }
    
    private func callRequest(){
        
        guard let id = output.searchResult.value?.id else { return }
        
        NetworkManager.shared.callRequest(api: .photoStatistics(id: id)) { [weak self] (response: StatisticsResponse, statusCode: Int) in
            self?.output.resultStatistics.value = response
        } failHandler: { [weak self] statusCode in
            print("ERROR Code: \(statusCode)")
        }
    }
}
