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
        
    }
    
    struct Output{
        
    }
    
    func tranform(input: Input) -> Output {
        return Output()
    }
}
