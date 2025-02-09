//
//  MainViewModel.swift
//  study2
//
//  Created by 이상민 on 2/6/25.
//

import Foundation

final class MainViewModel{
    
    let inputSearchBarReturnButtonTapped: Observable<String?> = Observable(nil)
    
    let outputSearchBarText: Observable<String?> = Observable(nil)
    
    init(){
        print("MainViewModel init")
    }
    
    deinit{
        print("MainViewModel deinit")
    }
}
