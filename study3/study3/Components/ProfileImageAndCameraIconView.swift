//
//  ProfileImageAndCameraIconView.swift
//  study3
//
//  Created by 이상민 on 2/9/25.
//

import UIKit
import SnapKit

class ProfileImageAndCameraIconView: BaseView {

    private(set) var selectedImageView = ProfileImageView()
    
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

    override func configureHierarchy() {
        self.addSubview(selectedImageView)
        self.addSubview(cameraIcon)
    }
    
    override func configureLayout() {
        self.selectedImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.cameraIcon.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            // TODO: 최대 20으로 수정
            make.size.equalTo(20)
        }
    }
}
