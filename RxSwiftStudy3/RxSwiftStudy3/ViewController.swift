//
//  ViewController.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let disposeBag = DisposeBag()
    
    let textFieldText = PublishSubject<String>()
    
    let publisSubject = PublishSubject<Int>() //PublishSubject: 초기값 없음
    let behaviorSubject = BehaviorSubject(value: 0) //BehaviorSubject: 초기값 설정해줘야 함
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        bindTextField()
    }
    
    func bindTextField(){
        textFieldText
            .subscribe(with: self) { owner, value in
                owner.nicknameTextField.text = value
                print("111111")
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.textFieldText.onNext("5")
            }
            .disposed(by: disposeBag)
    }
    
//    func bindTextField(){
//        //버튼 선택으로 textfield의 값을 변경해주면 위의 textfield실시간 반영 코드는 실행될까?
//        //=> textfield에 값은 반영되지만 orEmpty는 실행안됨, 그러니 구독이 끊어진 것은 아니다!
//        //UI처리에 특화된 Observable(전달만 가능, 값을 받을 수는 없음)이 Trait
//        //RxCocoa의 Trait은 ControlProperty, ControlEvent, Driver
//        nicknameTextField.rx.text.orEmpty
//            .subscribe(with: self) { owner, value in
//                print(#function, value)
//                print("실시간으로 텍스트필드 달라짐")
//            } onError: { owner, error in
//                print(#function, "onError")
//            } onCompleted: { owner in
//                print(#function, "onCompleted")
//            } onDisposed: { owner in
//                print(#function, "onDisposed")
//            }
//            .disposed(by: disposeBag)
//        
//        nextButton.rx.tap
//            .bind(with: self) { owner, _ in
//                owner.nicknameTextField.text = "5"
//            }
//            .disposed(by: disposeBag)
//        
//        /*
//            //처음에는 초기값이 없기에 출력안됨.
//            //버튼 클릭으로 값이 들어오면 출력됨
//            publisSubject
//                .subscribe(with: self) { owner, value in
//                    print(#function, value)
//                    print("publisSubject")
//                } onError: { owner, error in
//                    print(#function, "onError")
//                } onCompleted: { owner in
//                    print(#function, "onCompleted")
//                } onDisposed: { owner in
//                    print(#function, "onDisposed")
//                }
//                .disposed(by: disposeBag)
//            
//            behaviorSubject
//                .subscribe(with: self) { owner, value in
//                    print(#function, value)
//                    print("behaviorSubject")
//                } onError: { owner, error in
//                    print(#function, "onError")
//                } onCompleted: { owner in
//                    print(#function, "onCompleted")
//                } onDisposed: { owner in
//                    print(#function, "onDisposed")
//                }
//                .disposed(by: disposeBag)
//         */
//    }
    
    /*
     //subscribe: next, complete, error, 메인쓰레드 실행을 보장 x
     //bind: next. 메인쓰레드 실행을 보장 x
     //drive, 메인쓰레드 실행을 보장, 쓰레드 공유
     //Trait - Driver, ControlPropertey, ControlEvent etc...
     func bindButton(){
     //MARK: - 1) subscribe
     //        nextButton.rx.tap
     //            .subscribe(with: self) { owner, _ in
     //                print(#function, "클릭")
     //            } onError: { owner, error in
     //                print(#function, "onError")
     //            } onCompleted: { owner in
     //                print(#function, "onCompleted")
     //            } onDisposed: { owner in
     //                print(#function, "onDisposed")
     //            }
     //            .disposed(by: disposeBag)
     
     //MARK: - 2) bind
     //        //버튼 > 서버통신(비동기) > UI업데이트(main Thread)
     //        nextButton.rx.tap
     //            .map{
     //                print("observe 전",Thread.isMainThread)
     //            }
     ////            .observe(on: MainScheduler.instance) //이 코드 뒤의 코드는 Main Thread에서 실행하겠어. 라는 의미의 코드
     //            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default)) //이 코드 뒤의 코드는 Background Thread에서 실행하겠어. 라는 의미의 코드
     //            .map{
     //                print("observe 후",Thread.isMainThread)
     //            }
     //            .bind(with: self) { owner, _ in
     //                print("bind 했을 때",Thread.isMainThread)
     //                print(#function, "클릭")
     //                //메인
     //            }
     //            .disposed(by: disposeBag)
     
     //MARK: - 3) drive
     nextButton.rx.tap
     .asDriver()
     .drive(with: self){ owner, _ in
     print("drive")
     }
     .disposed(by: disposeBag)
     
     }
     */
    
//    func bindButton(){
//        let button = nextButton.rx.tap
//            .map{ print("버튼 클릭")}
//            .debug("1")
//            .debug("2")
//            .debug("3")
//            .map{ "안녕하세요 \(Int.random(in: 1...100))"}
//        //Driver의 경우 share연산자를 내부적으로 가지고 있어서 사용하지 않아도 됨
////            .share() //하나의 subscribe를 공유하도록
////            .asDriver(onErrorJustReturn: "") //실패를 하거나 문자가 안 올때 해당 값을 return 해줘라
//        
//        //MARK: - 기본 bind 예제
//        
//         button
//         .bind(with: self) { owner, value in
//         print("1", value)
//         }
//         .disposed(by: disposeBag)
//         
//         button
//         .bind(with: self) { owner, value in
//         print("2", value)
//         }
//         .disposed(by: disposeBag)
//         
//         button
//         .bind(with: self) { owner, value in
//         print("3", value)
//         }
//         .disposed(by: disposeBag)
//         
//         /*
//          1 안녕하세요 13
//          2 안녕하세요 98
//          3 안녕하세요 50
//          */
//        
//        //MARK: - share 연산자를 사용한 예제
//        /*
//            button
//                .bind(to: navigationItem.rx.title)
//                .disposed(by: disposeBag)
//            
//            button
//                .bind(to: nextButton.rx.title())
//                .disposed(by: disposeBag)
//            
//            button
//                .bind(to: nicknameTextField.rx.text)
//                .disposed(by: disposeBag)
//            
//            /*
//             각 to: _ 에 해당하는 곳에 같은 값들이 존재함
//             */
//         */
//        
//        //MARK: - drive 바인딩을 사용한 예제
//        /*
//            button
//                .drive(navigationItem.rx.title)
//                .disposed(by: disposeBag)
//            
//            button
//                .drive(nextButton.rx.title())
//                .disposed(by: disposeBag)
//            
//            button
//                .drive(nicknameTextField.rx.text)
//                .disposed(by: disposeBag)
//            
//            /*
//             각 to: _ 에 해당하는 곳에 같은 값들이 존재함
//             */
//         */
//    }
    
    func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
        
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
}

