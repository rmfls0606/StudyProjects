//
//  NumbersViewController.swift
//  RxSwiftStudy
//
//  Created by 이상민 on 2/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NumbersViewController: UIViewController {
    private let calculatorView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .trailing
        return view
    }()
    
    private let number1: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.textAlignment = .right
        return textField
    }()
    
    private let number2: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.textAlignment = .right
        return textField
    }()
    
    private let threeRowView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fill
        view.alignment = .center
        return view
    }()
    
    private let plusImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "plus")
        view.tintColor = .black
        return view
    }()
    
    private let number3: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.textAlignment = .right
        return textField
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let result: UILabel = {
        let label = UILabel()
        label.text = "-1"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setView()
        setBind()
    }
    
    func setUI(){
        self.view.addSubview(calculatorView)
        self.calculatorView.addArrangedSubview(number1)
        self.calculatorView.addArrangedSubview(number2)
        self.calculatorView.addArrangedSubview(threeRowView)
        
        self.threeRowView.addArrangedSubview(plusImage)
        self.threeRowView.addArrangedSubview(number3)
        
        self.calculatorView.addArrangedSubview(lineView)
        self.calculatorView.addArrangedSubview(result)
    }
    
    func setLayout(){
        self.calculatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.number1.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        self.number2.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        self.plusImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        self.number3.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        self.lineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func setView(){
        self.view.backgroundColor = .white
    }
    
    func setBind(){
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty){ textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
    }
}
