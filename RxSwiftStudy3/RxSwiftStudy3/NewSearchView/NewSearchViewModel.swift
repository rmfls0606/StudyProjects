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
        let list: Observable<[DailyBoxOfficeList]>
    }
    
    func transform(input: Input) -> Output{
        let list = PublishSubject<[DailyBoxOfficeList]>()
        
        //map, withLatestFrom, flatmap, flatMapLatest etc...
        input.searchTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .map{
                guard let text = Int($0) else {
                    return 20250223
                }
                return text
            }
            .map{ return "\($0)"}
        //            .map{ //value가 Observable 타입이라 2번 subscribe해줘야함 -> flatMap을 사용하자
        //                NetworkManager.shared.callBoxOffice(date: $0)
        //            }
            .flatMap{
                //                NetworkManager.shared.callBoxOffice(date: $0)
                //                    .debug("movie")
                //                    .catch { error in
                //
                //                        print("movie error", error)
                //                        let dummy = Movie(
                //                            boxOfficeResult: BoxOfficeResult(
                //                                dailyBoxOfficeList: [DailyBoxOfficeList(movieNm: "잭잭", openDt: "2025.01.01")]
                //                            )
                //                        )
                //                        return Observable.just(dummy)
                //                    }
                NetworkManager.shared.callBoxOfficeWithSingle(date: $0)
                    .debug("single movie")
                    .catch { error in
                        print("movie error", error)
                        let dummy = Movie(
                            boxOfficeResult: BoxOfficeResult(
                                dailyBoxOfficeList: [DailyBoxOfficeList(movieNm: "잭잭", openDt: "2025.01.01")]
                            )
                        )
                        return Single.just(dummy)
                    }
                    .debug("single movie")
            }
            .debug("tap")
            .subscribe(
                with: self) { owner, value in
                    
                    print("tap next", value)
                    
                    list.onNext(value.boxOfficeResult.dailyBoxOfficeList)
                    
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
