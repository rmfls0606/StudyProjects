//
//  SimpleValidationViewController.swift
//  RxSwiftStudy
//
//  Created by 이상민 on 2/19/25.
//

import UIKit
import SnapKit

class SimpleValidationViewController: UIViewController {
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
    }
    
    func setBind(){
        
    }
}
