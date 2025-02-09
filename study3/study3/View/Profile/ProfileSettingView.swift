//
//  ProfileSettingView.swift
//  study3
//
//  Created by 이상민 on 2/8/25.
//

import UIKit
import SnapKit

protocol ProfileSettingViewDelegate: AnyObject {
    func didSelectMBTIButton(groupIndex: Int, selectedOption: String)
    func didSelectSuccessButton()
}

class ProfileSettingView: BaseView {
    
    private var buttonGroups: [[UIButton]] = []
    weak var delegate: ProfileSettingViewDelegate?
    
    private(set) lazy var profileImageAndCameraIconView = ProfileImageAndCameraIconView()

    private lazy var profileNickenameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요 :)"
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [.foregroundColor: UIColor(named: "lightGrayColor")!])
        textField.borderStyle = .none
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    private lazy var profileNicknameLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lightGrayColor")
        return view
    }()
    
    private lazy var profileNicknameValidTextt: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "lightGrayColor")
        label.text = "닉네임에 숫자는 포함할 수 없어요"
        return label
    }()
    
    private lazy var mbtiTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "MBTI"
        return label
    }()
    
    private lazy var mbtiStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var mbtiOuterStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [mbtiTitle, mbtiStackView])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .top
        return view
    }()
    
    private lazy var successButton: UIButton = {
        let btn = UIButton(configuration: .filled())
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(named: "unSuccessColor")
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.background.strokeColor = UIColor(named: "unSuccessColor")
        config.background.strokeWidth = 2.0
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        config.titleAlignment = .center
        
        var title = AttributedString("완료")
        title.font = UIFont.boldSystemFont(ofSize: 14)
        config.attributedTitle = title
        
        btn.configuration = config
        btn.isUserInteractionEnabled = false
        btn.addTarget(self, action: #selector(successButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override func configureHierarchy() {
        self.addSubview(profileImageAndCameraIconView)
        self.addSubview(profileNickenameTextField)
        self.addSubview(profileNicknameLine)
        self.addSubview(profileNicknameValidTextt)
        self.addSubview(mbtiOuterStackView)
        self.addSubview(successButton)
    }
    
    override func configureLayout() {
        self.profileImageAndCameraIconView.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }
        
        self.profileNickenameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(profileImageAndCameraIconView.snp.bottom).offset(24)
        }
        
        self.profileNicknameLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(profileNickenameTextField.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        self.profileNicknameValidTextt.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(profileNicknameLine.snp.bottom).offset(10)
        }
        
        self.mbtiTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
        
        self.mbtiOuterStackView.snp.makeConstraints { make in
            make.top.equalTo(profileNicknameValidTextt.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        self.successButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(mbtiOuterStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    override func configureView() {
        self.configureMbtiButtons()
    }
    
    private func configureMbtiButtons(){
        let mbtiTextGroups = [["E","I"], ["S", "N"], ["T", "F"], ["J", "P"]]
        
        for groupIndex in 0..<mbtiTextGroups.count {
            let stackView: UIStackView = {
                let view = UIStackView()
                view.axis = .vertical
                view.spacing = 10
                view.distribution = .fillEqually
                return view
            }()
            
            var buttons: [UIButton] = []
            
            for title in mbtiTextGroups[groupIndex] {
                let button = createButton(title: title, row: groupIndex)
                DispatchQueue.main.async {
                    button.layer.cornerRadius = button.bounds.width / 2
                }
                buttons.append(button)
                stackView.addArrangedSubview(button)
            }
            
            self.buttonGroups.append(buttons)
            mbtiStackView.addArrangedSubview(stackView)
        }
    }
    
    private func createButton(title: String, row: Int) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(named: "lightGrayColor"), for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "lightGrayColor")?.cgColor
        button.addAction(UIAction{ [weak self] _ in
            self?.mbtiButtonTapped(selectedButton: button, row: row)
        }, for: .touchUpInside)
        // Todo: 최대 60으로
        button.snp.makeConstraints { make in
            make.size.equalTo(60)
        }
        return button
    }
    
    func configureDelegate(delegate: UITextFieldDelegate){
        self.profileNickenameTextField.delegate = delegate
    }
    
    func configureNickenameValidResultText(_ text: String?, color: UIColor){
        self.profileNicknameValidTextt.text = text
        self.profileNicknameValidTextt.textColor = color
    }
    
    func configureImage(imageName: String){
        let image = UIImage(named: imageName)
        self.profileImageAndCameraIconView.selectedImageView.image = image
    }
    
    private func mbtiButtonTapped(selectedButton: UIButton, row: Int){
        
        let currentIsSelected = selectedButton.isSelected
        var selectedOption = ""
        
        for button in buttonGroups[row]{
            button.isSelected = false
            button.backgroundColor = .white
        }
        
        if currentIsSelected{
            selectedButton.backgroundColor = .white
            selectedOption = ""
        }else{
            selectedButton.isSelected = true
            selectedOption = selectedButton.currentTitle!
            selectedButton.backgroundColor = UIColor(named: "blueColor")
        }
        delegate?.didSelectMBTIButton(groupIndex: row, selectedOption: selectedOption)
    }
    
    func configureSuccessButtonState(isEnabled: Bool){
        if isEnabled{
            successButton.configuration?.baseBackgroundColor = UIColor(named: "successColor")
        }else{
            successButton.configuration?.baseBackgroundColor = UIColor(named: "unSuccessColor")
        }
        successButton.isUserInteractionEnabled = isEnabled
    }
    
    @objc
    private func successButtonTapped(){
        delegate?.didSelectSuccessButton()
    }
}
