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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        bindButton()
    }
    
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
    
    func bindButton(){
        let button = nextButton.rx.tap
            .map{ "안녕하세요 \(Int.random(in: 1...100))"}
            
        //MARK: - 기본 bind 예제
        /*
            button
                .bind(with: self) { owner, value in
                    print("1", value)
                }
                .disposed(by: disposeBag)

            button
                .bind(with: self) { owner, value in
                    print("2", value)
                }
                .disposed(by: disposeBag)

            button
                .bind(with: self) { owner, value in
                    print("3", value)
                }
                .disposed(by: disposeBag)
            
            /*
             1 안녕하세요 13
             2 안녕하세요 98
             3 안녕하세요 50
             */
         */
    }
    
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

