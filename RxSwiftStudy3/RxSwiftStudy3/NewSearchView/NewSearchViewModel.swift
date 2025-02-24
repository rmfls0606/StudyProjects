//
//  NewSearchViewModel.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/24/25.
//

import Foundation
import RxSwift
import RxCocoa

final class NewSearchViewModel{
    
    let disposeBag = DisposeBag()

    struct Input{
        let searchTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output{
        let list: Observable<[String]>
    }
    
    func transform(input: Input) -> Output{
        let list = Observable.just(["가", "나", "디"])
        
        //map, withLatestFrom, flatmap, flatMapLatest etc...
        input.searchTap
            .withLatestFrom(input.searchText)
            .subscribe(
                with: self) { owner, value in
                    print("next", value)
                } onError: { owner, error in
                    print("onError")
                } onCompleted: { owner in
                    print("onCompleted")
                } onDisposed: { owner in
                    print("onDisposed")
                }
                .disposed(by: disposeBag)
        
        return Output(list: list)
    }
}
