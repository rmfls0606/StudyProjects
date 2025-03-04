//
//  LottoViewModel.swift
//  Lotto
//
//  Created by 이상민 on 2/24/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class LottoViewModel{
    
    private let disposeBag = DisposeBag()
    let lottoRoundData = [Int](1...1160).reversed().map{Int($0)}
    
    struct Input{
        let pickerGesture: ControlEvent<(row: Int, component: Int)>
        let observabledBtnTap: ControlEvent<Void>
        let singleBtnTap: ControlEvent<Void>
    }
    
    struct Output{
        let lottoRound: Observable<[Int]>
        let lottoData: PublishSubject<Lotto>
        let selectedRound: Observable<Int>
    }
    
    func transform(input: Input) -> Output{
        let lottoRound = Observable.just(lottoRoundData) //현재 1160회차
        let lottoData = PublishSubject<Lotto>()
        
        let pickerSelected = input.pickerGesture
            .withLatestFrom(lottoRound){ (pickerSelection, lottoRounds) -> Int in
                let (row, _) = pickerSelection
                return lottoRounds[row]
            }
            .startWith(lottoRoundData.first!)
        
        let buttonSelectedRound = Observable.merge(
            input.observabledBtnTap.map{self.lottoRoundData.first!},
            input.singleBtnTap.map{self.lottoRoundData.first!}
        )
        
        let selectedRound = Observable.merge(pickerSelected, buttonSelectedRound)
            .startWith(lottoRoundData.first!)
        
        pickerSelected
            .flatMapLatest({ round in
                self.ObservableCallLotto(round: round)
            })
            .subscribe(with: self, onNext: { owner, value in
                lottoData.onNext(value)
            })
            .disposed(by: disposeBag)
        
        input.observabledBtnTap
            .map{ self.lottoRoundData.first!}
            .flatMapLatest { round in
                self.ObservableCallLotto(round: round)
            }
            .subscribe(with: self) { owner, value in
                lottoData.onNext(value)
            }
            .disposed(by: disposeBag)
        
        input.singleBtnTap
            .map{ self.lottoRoundData.first!}
            .flatMapLatest { round in
                self.SingleCallLotto(round: round)
            }
            .subscribe(with: self) { owner, value in
                lottoData.onNext(value)
            }
            .disposed(by: disposeBag)
        
        return Output(lottoRound: lottoRound, lottoData: lottoData, selectedRound: selectedRound)
    }
    
    //MARK: - Observable로 구현한 방식
    func ObservableCallLotto(round: Int) -> Observable<Lotto>{
        
        return Observable<Lotto>.create { value in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
            
            guard let url = URL(string: url) else{
                print("URL 에러")
                return Disposables.create {
                    print("끝")
                }
            }
            
            URLSession.shared.dataTask(with: url){ data, response, error in
                if let error = error{
                    print("에러: \(error.localizedDescription)")
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else{
                    print("Status 에러")
                    return
                }
                
                if let data = data{
                    do{
                        let result = try JSONDecoder().decode(Lotto.self, from: data)
                        value.onNext(result)
                        value.onCompleted()
                    }catch{
                        print("디코딩 실패", error.localizedDescription)
                    }
                }else{
                    print("알수 없는 에러 발생")
                }
            }
            .resume()
            
            return Disposables.create {
                print("끝")
            }
        }
    }
    
    //MARK: - Observable로 구현한 방식
    func SingleCallLotto(round: Int) -> Single<Lotto>{
        
        return Single<Lotto>.create { value in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
            
            guard let url = URL(string: url) else{
                print("URL 에러")
                return Disposables.create {
                    print("끝")
                }
            }
            
            URLSession.shared.dataTask(with: url){ data, response, error in
                if let error = error{
                    print("에러: \(error.localizedDescription)")
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else{
                    print("Status 에러")
                    return
                }
                
                if let data = data{
                    do{
                        let result = try JSONDecoder().decode(Lotto.self, from: data)
                        value(.success(result))
                    }catch{
                        print("디코딩 실패", error.localizedDescription)
                    }
                }else{
                    print("알수 없는 에러 발생")
                }
            }
            .resume()
            
            return Disposables.create {
                print("끝")
            }
        }
    }
}



