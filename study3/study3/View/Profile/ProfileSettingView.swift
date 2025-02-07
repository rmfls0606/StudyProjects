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
    
    override func configureHierarchy() {
        self.addSubview(profileImageUIView)
        self.profileImageUIView.addSubview(selectedImageView)
        self.profileImageUIView.addSubview(cameraIcon)
    }
    
    override func configureLayout() {
        
        self.profileImageUIView.snp.makeConstraints { make in
            // TODO: 최대 80으로 수정
            make.size.equalTo(80)
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }
        
        selectedImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cameraIcon.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            // TODO: 최대 20으로 수정
            make.size.equalTo(20)
        }
    }
}
