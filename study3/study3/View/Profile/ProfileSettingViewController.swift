//
//  ProfileSettingViewController.swift
//  study3
//
//  Created by 이상민 on 2/8/25.
//

import UIKit
import SnapKit

final class ProfileSettingViewController: UIViewController {

    private let profileSetiingView = ProfileSettingView()
    
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setLayout()
        setLogic()
        setBind()
    }
    
    private func setUI(){
        self.view.addSubview(profileSetiingView)
        self.view.backgroundColor = .white
    }
    
    private func setLayout(){
        self.profileSetiingView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setLogic(){
        self.profileSetiingView.configureDelegate(delegate: self)
    }
    
    private func setBind(){
        viewModel.ouputNicknameValidResultText.bind { [weak self] text in
            self?.profileSetiingView.configureNickenameValidResultText(text)
        }
    }
}

//UITextField
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.viewModel.inputNicknameTextfield.value = textField.text
    }
}
