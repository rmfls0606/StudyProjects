//
//  OnboardingViewController.swift
//  study3
//
//  Created by 이상민 on 2/8/25.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    private let onboardingView = OnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setLayout()
    }
    
    private func setUI(){
        self.view.addSubview(self.onboardingView)
        self.view.backgroundColor = .white
    }
    
    private func setLayout(){
        self.onboardingView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
