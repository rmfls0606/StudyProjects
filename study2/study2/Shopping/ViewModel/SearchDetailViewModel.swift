//
//  SearchDetailViewModel.swift
//  study2
//
//  Created by 이상민 on 2/6/25.
//

import Foundation
import Alamofire

final class SearchDetailViewModel{
    
    let outputSearchText: Observable<String?> = Observable(nil)
    let inputSortOptionResult: Observable<sortOptions> = Observable(.sim)
    
    let outputItemList: Observable<[Item]> = Observable([])
    
    init(){
        print("SearchDetailViewModel init")
        
        inputSortOptionResult.bind { [weak self] sortOption in
            self?.callRequest(sortOption: sortOption)
        }
        
//        outputSearchText.bind { [weak self] text in
//            self?.callRequest(sortOption: .sim)
//        }
    }
    
    deinit{
        print("SearchDetailViewModel deinit")
    }
    
    private func callRequest(sortOption: sortOptions){
        
        guard let query = outputSearchText.value, query.count >= 2 else { return }
        let url = "https://openapi.naver.com/v1/search/shop.json?"

        let parameters: [String: Any] = [
            "query": query,
            "sort": sortOption.rawValue,
            "display": 100
        ]
        
        let headers: HTTPHeaders = HTTPHeaders([
            "X-Naver-Client-Id": Bundle.main.infoDictionary?["XNaverClientId"] as! String,
            "X-Naver-Client-Secret": Bundle.main.infoDictionary?["XNaverClientSecret"] as! String
        ])
        
        NetworkManager.shared.loadData(url: url,
                                       method: .get,
                                       parameters: parameters,
                                       headers: headers) { [weak self] (result: Result<ItemList, Error>) in
            switch result{
            case .success(let data):
                self?.outputItemList.value = data.items
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            
        }
    }
}
