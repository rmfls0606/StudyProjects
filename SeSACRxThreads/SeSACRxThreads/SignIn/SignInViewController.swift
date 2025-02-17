//
//  SignInViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "로그인")
    let signUpButton = UIButton()
    
    let emailText = Observable.just("aaaddc")
    
    let backgroundColor = Observable.just(UIColor.lightGray)
    
    let signUpTitle = Observable.just("회원이 아직 아니십니까?")
    let signUpTitleColor = Observable.just(UIColor.red)
    
    let disposeBag = DisposeBag()
    
    func bindBackgroundColor(){
        backgroundColor
            .subscribe { value in
                self.view.backgroundColor = value
            } onError: { error in
                print(#function, error)
            } onCompleted: {
                print(#function, "onCompleted")
            } onDisposed: {
                print(#function, "onDisposed")
            }
            .disposed(by: disposeBag)
    
        //MARK: - 순환참조 이슈 해결: [weak self], withUnretained
//        backgroundColor
//            .withUnretained(self)
//            .subscribe { value in
//                self.view.backgroundColor = value
//            } onError: { error in
//                print(#function, error)
//            } onCompleted: {
//                print(#function, "onCompleted")
//            } onDisposed: {
//                print(#function, "onDisposed")
//            }
//            .disposed(by: disposeBag)
    
        //MARK: - 이미 메소드가 있기에 해당 사용을 권장
        backgroundColor
            .subscribe(with: self) { owner, value in
                owner.view.backgroundColor = value
            } onError: { owner, error in
                print(#function, error)

            } onCompleted: { owner in
                print(#function, "onCompleted")

            } onDisposed: { owner in
                print(#function, "onDisposed")

            }
            .disposed(by: disposeBag)

        //MARK: - 호출 되지 않는 이벤트 생략
        backgroundColor
            .subscribe(with: self) { owner, value in
                owner.view.backgroundColor = value
            } onDisposed: { owner in
                print(#function, "onDisposed")

            }
            .disposed(by: disposeBag)
        
        //위의 코드처럼 지워도 되지만 이렇게 bind메소드를 사용하면 됨
        //이벤트를 받지 못하는 bind, next만 동작되면 되는 기능이라면 bind로 구현
        backgroundColor
            .bind(with: self) { owner, value in
                owner.view.backgroundColor = value
            }
            .disposed(by: disposeBag)
        
        //위와 같은 동작을 하는 코드
        backgroundColor
            .bind(to: view.rx.backgroundColor)
            .disposed(by: disposeBag)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        bindBackgroundColor()
        
//        signUpButton.addTarget(self, action: #xselector(signUpButtonClicked), for: .touchUpInside)
        
        // async, stream
//        signUpButton
//            .rx
//            .tap
//            .bind { _ in // bind == subscribe -> 대신 Error, Completed 가 없다 / 주로 UI 에서 사용
//                self.navigationController?.pushViewController(SignUpViewController(), animated: true)
//        }.disposed(by: disposeBag)
        
        signUpButton
            .rx
            .tap // 여기까지가 Observable
            .subscribe { _ in
                print("button tap onNext")
                self.navigationController?.pushViewController(SignUpViewController(), animated: true)
            }.disposed(by: disposeBag)
        
        
        emailText.subscribe { value in
            print("emailTextField onNext")
            self.emailTextField.text = value
        } onError: { error in
            print("emailTextField onError")
        } onCompleted: {
            print("emailTextField onCompleted")
        } onDisposed: {
            print("emailTextField onDisposed")
        }.disposed(by: disposeBag)

    }
    
//    @objc func signUpButtonClicked() {
//        navigationController?.pushViewController(SignUpViewController(), animated: true)
//    }
    
    
    func configure() {
//        signUpButton.setTitle("회원이 아니십니까?", for: .normal)
//        signUpButton.setTitleColor(Color.black, for: .normal)
        signUpTitle
            .bind(to: signUpButton.rx.title())
            .disposed(by: disposeBag)
        
        signUpTitleColor
//            .bind(to: signInButton.rx.tintColor)
        
        //해당 코드로는 제대로 동작하지 않으므로 아래 코드로 작성해줘야한다.
            .bind(with: self, onNext: { owner, color in
                owner.signUpButton.setTitleColor(color, for: .normal)
            })
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}

