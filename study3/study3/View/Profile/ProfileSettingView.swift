//
//  ProfileSettingView.swift
//  study3
//
//  Created by 이상민 on 2/8/25.
//

import UIKit
import SnapKit

class ProfileSettingView: BaseView {
    private lazy var selectedImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        // TODO: remove code
        view.image = UIImage(named: "profile_1")
        view.layer.borderColor = UIColor(named: "blueColor")?.cgColor
        view.layer.borderWidth = 3.0
        return view
    }()
    
    private lazy var cameraIcon: UIButton = {
        let btn = UIButton(configuration: .filled())
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(named: "blueColor")
        config.baseForegroundColor = .white
        
        // TODO: 버튼의 높이에 맞게 -12하기
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 8)
        let image = UIImage(systemName: "camera.fill", withConfiguration: imageConfig)
        
        config.image = image
        btn.configuration = config
        return btn
    }()
    
    private lazy var profileImageUIView: UIView = {
        let view = UIView()
        return view
    }()
    
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
        return label
    }()
    
    override func configureHierarchy() {
        self.addSubview(profileImageUIView)
        self.profileImageUIView.addSubview(selectedImageView)
        self.profileImageUIView.addSubview(cameraIcon)
        
        self.addSubview(profileNickenameTextField)
        self.addSubview(profileNicknameLine)
        self.addSubview(profileNicknameValidTextt)
    }
    
    override func configureLayout() {
        
        self.profileImageUIView.snp.makeConstraints { make in
            // TODO: 최대 80으로 수정
            make.size.equalTo(80)
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }
        
        self.selectedImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.cameraIcon.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            // TODO: 최대 20으로 수정
            make.size.equalTo(20)
        }
        self.profileNickenameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(12)
            make.top.equalTo(profileImageUIView.snp.bottom).offset(12)
            make.height.equalTo(350)
        }
        
    }
}
