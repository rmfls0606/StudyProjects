//
//  WordCounterViewModel.swift
//  study1
//
//  Created by 이상민 on 2/5/25.
//

import Foundation

class WordCounterViewModel{
    var inputTextView: Observable<String?> = Observable(nil)
    
    var countLabel: Observable<String?> = Observable(nil)

    init(){
        self.inputTextView.bind { text in
            self.validation()
        }
    }
    
    private func validation(){
        guard let text = inputTextView.value, !text.isEmpty else{
            countLabel.value = "현재까지 \(0)글자 작성중"
                return
        }
        
        countLabel.value = "현재까지 \(text.count)글자 작성중"
        
    }
}
