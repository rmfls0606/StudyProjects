//
//  BirthdayViewController.swift
//  RxSwiftStudy
//
//  Created by 이상민 on 2/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BirthdayViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "년"
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "월"
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "일"
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
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
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(yearLabel)
        self.stackView.addArrangedSubview(monthLabel)
        self.stackView.addArrangedSubview(dayLabel)
        
        self.view.addSubview(datePicker)
    }
    
    func setLayout(){
        self.stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(14)
        }
        
        self.datePicker.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(14)
        }
    }
    
    func setView(){
        self.view.backgroundColor = .white
    }
    
    func setBind(){
        datePicker
            .rx
            .date
            .map{ date -> (year: String, month: String, day: String) in
                let current = Calendar.current
                let components = current.dateComponents([.year, .month, .day], from: date)
                let year = "\(components.year ?? 0)"
                let month = "\(components.month ?? 0)"
                let day = "\(components.day ?? 0)"
                return (year, month, day)
            }
            .bind(with: self, onNext: { owner, components in
                owner.yearLabel.text = components.year
                owner.monthLabel.text = components.month
                owner.dayLabel.text = components.day
            })
            .disposed(by: disposeBag)
    }
}
