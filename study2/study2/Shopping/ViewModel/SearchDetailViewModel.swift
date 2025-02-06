//
//  SearchDetailViewModel.swift
//  study2
//
//  Created by 이상민 on 2/6/25.
//

import Foundation

final class SearchDetailViewModel{
    
    let outputSearchText: Observable<String?> = Observable(nil)
    
    init(){
        print("SearchDetailViewModel init")
    }
    
    deinit{
        print("SearchDetailViewModel deinit")
    }
}
