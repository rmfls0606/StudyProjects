//
//  LottoViewModel.swift
//  Lotto
//
//  Created by 이상민 on 2/24/25.
//

import Foundation
import RxSwift
import RxCocoa

class LottoViewModel{
    
    private let disposeBag = DisposeBag()
    let lottoRoundData = [Int](1...1160)
    
    struct Input{
        let pickerGesture: ControlEvent<(row: Int, component: Int)>
    }
    
    struct Output{
        let lottoRound: Observable<[Int]>
    }
    
    func transform(input: Input) -> Output{
        let lottoRound = Observable.just(lottoRoundData) //현재 1160회차
        
        input.pickerGesture
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
        
        return Output(lottoRound: lottoRound)
    }
}
