//
//  SignUpViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let validationButton = UIButton()
    let nextButton = PointButton(title: "다음")
    
    let emailPlaceholder = Observable.just("이메일을 입력해주세요.")
    
    var disposBag = DisposeBag()
    
    func bind(){
        //4자리 이상: 다음버튼 나타나고, 중복확인 버튼
        //4자리 미만: 다음버튼 x, 중복확인 버튼 click x
//        emailTextField
//            .rx
//            .text
//            .orEmpty //orEmpty 옵셔널을 풀어준다
//            .bind(with: self) { owner, value in
//                if value.count >= 4{
//                    owner.nextButton.isHidden = false
//                    owner.validationButton.isEnabled = true
//                }else{
//                    owner.nextButton.isHidden = true
//                    owner.validationButton.isEnabled = false
//                }
//            }
//            .disposed(by: disposBag)
        
//        let validation = emailTextField
//            .rx
//            .text
//            .orEmpty //String
//        
//        validation
//            .bind(with: self) { owner, value in
//                if value.count >= 4{
//                    owner.nextButton.isHidden = false
//                    owner.validationButton.isEnabled = true
//                }else{
//                    owner.nextButton.isHidden = true
//                    owner.validationButton.isEnabled = false
//                }
//            }
//            .disposed(by: disposBag)
        
        let validation = emailTextField
            .rx
            .text
            .orEmpty //String
            .map{ value in
                value.count >= 4
            }
        
        validation
//            .bind(to: nextButton.rx.isEnabled)
//            .disposed(by: disposBag)
            .subscribe(
                with: self) { owner, value in
                    owner.validationButton.isEnabled = value
                    print("Validation Next")
                } onDisposed: { owner in
                    print("Validation Disposed")
                }
                .dispose() //구독 즉시 취소
        //옵저버블 - 옵저버 사이가 끊김.

        
        validationButton.rx.tap
            .bind(with: self) { owner, _ in
                print("중복확인 버튼 클릭")
                owner.disposBag = DisposeBag()
            }
            .disposed(by: disposBag)
        
        emailPlaceholder
            .bind(to: emailTextField.rx.placeholder)
            .disposed(by: disposBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        bind()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)

    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(PasswordViewController(), animated: true)
    }

    func configure() {
        validationButton.setTitle("중복확인", for: .normal)
        validationButton.setTitleColor(Color.black, for: .normal)
        validationButton.layer.borderWidth = 1
        validationButton.layer.borderColor = Color.black.cgColor
        validationButton.layer.cornerRadius = 10
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(validationButton)
        view.addSubview(nextButton)
        
        validationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(validationButton.snp.leading).offset(-8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
