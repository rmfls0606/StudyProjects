//
//  SimpleValidationViewController.swift
//  RxSwiftStudy
//
//  Created by 이상민 on 2/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let minimainUsernameLenght: Int = 5
private let minimalPasswordLength: Int = 5

class SimpleValidationViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    private let usernameTitle: UILabel = {
        let label = UILabel()
        label.text = "Username"
        return label
    }()
    
    private let usernameOutlet: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let usernameValidOutlet: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .red
        label.text = "Label"
        return label
    }()
    
    private let passwordTitle: UILabel = {
        let label = UILabel()
        label.text = "Password"
        return label
    }()
    
    private let passwordOutlet: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordValidOutlet: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .red
        label.text = "Label"
        return label
    }()
    
    private let doSomethingOutlet: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Do something", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setView()
        setBind()
    }
    
    func setUI(){
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(usernameTitle)
        self.stackView.addArrangedSubview(usernameOutlet)
        self.stackView.addArrangedSubview(usernameValidOutlet)
        self.stackView.addArrangedSubview(passwordTitle)
        self.stackView.addArrangedSubview(passwordOutlet)
        self.stackView.addArrangedSubview(passwordValidOutlet)
        self.stackView.addArrangedSubview(doSomethingOutlet)
    }
    
    func setLayout(){
        self.stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(14)
        }
    }
    
    func setView(){
        self.view.backgroundColor = .white
        
        usernameValidOutlet.text = "유저명은 적어도 5글자는 입력되어야 합니다."
        passwordValidOutlet.text = "비밀번호는 적어도 5글자는 입력되어야 합니다."
    }
    
    func setBind(){
        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map{ $0.count >= minimainUsernameLenght }
            .share(replay: 1)
        
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map{ $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
        
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .bind(with: self) { owner, value in
                owner.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
