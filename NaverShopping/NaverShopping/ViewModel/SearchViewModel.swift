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
    }
    
    struct Output{
        let items: PublishRelay<[Item]>
    }
    
    func tranform(input: Input) -> Output {
        let items = PublishRelay<[Item]>()
        
        input.searchTrigger
            .flatMap { _ in
                NetworkManager.shared.callShoppingRequest(query: self.query)
                    .asObservable()
           }
            .subscribe(with: self, onNext: { owner, value in
                items.accept(value.items)
            })
            .disposed(by: disposeBag)
        return Output(items: items)
    }
}
