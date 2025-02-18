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
        
    }

}
