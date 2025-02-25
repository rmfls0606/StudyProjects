//
//  MainViewModel.swift
//  NaverShopping
//
//  Created by 이상민 on 2/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel{

    struct Input{
        let searchReturn: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output{
        let query: Observable<String>
    }
    
    func transform(input: Input) -> Output{
        let query = input.searchReturn
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .filter{ $0.count >= 2 }
        
        
        return Output(query: query)
    }
}
