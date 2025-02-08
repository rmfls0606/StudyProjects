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
    
    deinit {
        print("ProfileSettingViewController Deinit")
    }
    
    private func setUI(){
        self.view.addSubview(profileSetiingView)
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "PROFILE SETTING"
    }
    
    private func setLayout(){
        self.profileSetiingView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setLogic(){
        self.profileSetiingView.configureDelegate(delegate: self)
        self.randomSelectedProfileImage()
    }
    
    private func setBind(){
        viewModel.ouputNicknameValidResultText.bind { [weak self] text in
            self?.profileSetiingView.configureNickenameValidResultText(text)
        }
    
        viewModel.outputProfileImage.bind { [weak self] imageName in
            // todo: 기본 이미지 넣기
            self?.profileSetiingView.configureImage(imageName: imageName!)
        }
    }
    
    private func randomSelectedProfileImage(){
        let index = Int.random(in: 0...11)
        let imageName = "profile_\(index)"
        viewModel.outputProfileImage.value = imageName
    }
}

//UITextField
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.viewModel.inputNicknameTextfield.value = textField.text
    }
}

