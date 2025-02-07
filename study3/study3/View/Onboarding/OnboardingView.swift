//
//  OnboardingView.swift
//  study3
//
//  Created by 이상민 on 2/8/25.
//

import UIKit
import SnapKit

class OnboardingView: BaseView {

    private lazy var onboardingImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "onboarding")
        return view
    }()
    
    private lazy var onboardingTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.text = "Onboarding"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var onboardingContent: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "당신만의 영화 세상,\nMovieLike를 시작해보세요."
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var onboardingStartButton: UIButton = {
        let btn = UIButton(configuration: .bordered())
        
        var config = UIButton.Configuration.bordered()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = UIColor(named: "blueColor")
        config.cornerStyle = .capsule
        config.background.strokeColor = UIColor(named: "blueColor")
        config.background.strokeWidth = 2.0
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        config.titleAlignment = .center
        
        var title = AttributedString("시작하기")
        title.font = UIFont.boldSystemFont(ofSize: 14)
        config.attributedTitle = title
        
        btn.configuration = config
        return btn
    }()
    
    override func configureHierarchy() {
        self.addSubview(onboardingImageView)
        self.addSubview(onboardingTitle)
        self.addSubview(onboardingContent)
        self.addSubview(onboardingStartButton)
    }
    
    override func configureLayout() {
        self.onboardingImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.lessThanOrEqualTo(onboardingImageView.snp.width).multipliedBy(1.2)
        }
        
        self.onboardingTitle.snp.makeConstraints { make in
            make.top.equalTo(onboardingImageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        self.onboardingContent.snp.makeConstraints { make in
            make.top.equalTo(onboardingTitle.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        self.onboardingStartButton.snp.makeConstraints { make in
            make.top.equalTo(onboardingContent.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }

}
