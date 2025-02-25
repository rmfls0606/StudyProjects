//
//  SearchViewModel.swift
//  NaverShopping
//
//  Created by 이상민 on 2/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    private let query: String
    
    init(query: String) {
        self.query = query
    }
    
    struct Input{
        let searchTrigger: Observable<Void>
    }
    
    struct Output{
        let items: PublishSubject<ItemResponse>
    }
    
    func tranform(input: Input) -> Output {
        let items = PublishSubject<ItemResponse>()
        
        input.searchTrigger
            .flatMap {
                NetworkManager.shared.callShoppingRequest(query: self.query)
            }
            .subscribe(with: self) { owner, value in
                items.onNext(value)
            }
            .disposed(by: DisposeBag())
        
        return Output(items: items)
    }
}
