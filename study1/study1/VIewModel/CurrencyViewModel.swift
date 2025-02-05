//
//  CurrencyViewModel.swift
//  study1
//
//  Created by 이상민 on 2/5/25.
//

import Foundation

class CurrencyViewModel{
    var inputTextField: Observable<String?> = Observable(nil)
    
    var resultLabel: Observable<String?> = Observable(nil)
    var exchangeRateLabel: Observable<String?> = Observable(nil)
    
    // TODO: 실시간 환율 데이터 가져오기
    private let exchangeRate = 1446.40
    
    init(){
        self.inputTextField.bind { text in
            self.validation()
        }
        exchangeRateLabel.value = "현재 환율: 1 USD = \(exchangeRate) KRW"
    }
    
    private func validation(){
        guard let text = inputTextField.value,
              let num = Double(text) else {
            resultLabel.value = "올바른 금액을 입력해주세요"
            return
        }
        
        let convertedAmount = num / exchangeRate
        resultLabel.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
