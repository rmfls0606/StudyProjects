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
    private let disposeBag =  DisposeBag()
    
    init(query: String) {
        self.query = query
    }
    
    struct Input{
        let searchTrigger: Observable<Void>
        let sortOption: Observable<sortOptions>
    }
    
    struct Output{
        let items: PublishRelay<[Item]>
    }
    
    func tranform(input: Input) -> Output {
        let items = PublishRelay<[Item]>()
        
        Observable.combineLatest(input.searchTrigger, input.sortOption.startWith(.sim))
            .flatMap { (_, sortOption) -> Observable<ItemResponse> in
                NetworkManager.shared.callShoppingRequest(query: self.query, sortOption: sortOption)
                    .asObservable()
           }
            .subscribe(with: self, onNext: { owner, value in
                items.accept(value.items)
            })
            .disposed(by: disposeBag)
        return Output(items: items)
    }
}
