//
//  HomeworkViewModel.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeworkViewModel{
    let disposeBag = DisposeBag()
    
    var recent = ["킁킁"]
    var items = ["Test"]
    
    struct Input{
        let searchButtonTap: ControlEvent<Void> //엔터키
        let searchText: ControlProperty<String> //입력값
        let recentText: PublishSubject<String>
    }
    
    struct Output{
        let items: BehaviorSubject<[String]> //테이블뷰
        let recent: BehaviorRelay<[String]> //컬렉션뷰
    }
    
    func transform(input: Input) -> Output{
        let recentList = BehaviorRelay(value: recent)
        let itemsList = BehaviorSubject(value: items)
        
        //MARK: - search -> TableView append
        input.searchButtonTap
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .map{ "\($0)님"}
            .asDriver(onErrorJustReturn: "손님")
            .drive(with: self){ owner, value in
                owner.items.append(value)
                itemsList.onNext(owner.items)
            }
            .disposed(by: disposeBag)
        
        input.recentText
            .subscribe(
                with: self) { owner, value in
                    owner.recent.append(value)
                    recentList.accept(owner.recent)
                }
                .disposed(by: disposeBag)

        
        return Output(items: itemsList, recent: recentList)
    }
}
