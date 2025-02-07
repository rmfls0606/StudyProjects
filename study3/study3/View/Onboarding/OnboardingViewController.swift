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
    
    private let viewModel = OnboardingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setLayout()
        setLogic()
        setBind()
    }
    
    deinit{
        print("OnboardingViewController Deinit")
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
    
    private func setLogic(){
        onboardingView.onButtonTapped = self.moveNextViewController
    }
    
    private func setBind(){
        self.viewModel.outputNextButtonTapped.lazyBind { [weak self] _ in
            // TODO: 새로운 rootViewController로 설정
            let nextVC = ProfileSettingViewController()
            self?.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    private func moveNextViewController(){
        self.viewModel.outputNextButtonTapped.value = ()
    }
}
