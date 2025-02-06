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
        inputSearchBarReturnButtonTapped.lazyBind { [weak self] text in
            self?.validation()
        }
    }
    
    private func validation(){
        guard let text = inputSearchBarReturnButtonTapped.value, text.count >= 2 else{
            print("2글자 이상 입력해주세요.")
            return
        }
        outputSearchBarText.value = text
    }
    
    deinit{
        print("MainViewModel deinit")
    }
}
