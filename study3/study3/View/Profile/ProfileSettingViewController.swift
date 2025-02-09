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
        self.profileSetiingView.delegate = self
        self.profileSetiingView.configureDelegate(delegate: self)
        self.randomSelectedProfileImage()
        self.profileSetiingView.profileImageAndCameraIconView.onButtonTapped = moveSelectProfileImage
    }
    
    
    private func setBind(){
        viewModel.outputNicknameValidResultText.bind { [weak self] status in
            if status == .success {
                self?.profileSetiingView.configureNickenameValidResultText(status.description, color: .blue)
            }else{
                self?.profileSetiingView.configureNickenameValidResultText(status.description, color: .red)
            }
            self?.viewModel.profleSuccessEnable()
        }
    
        viewModel.outputProfileImage.bind { [weak self] imageName in
            // todo: 기본 이미지 넣기
            self?.profileSetiingView.configureImage(imageName: imageName!)
        }
        
        viewModel.inputMoveSelectedImageButtonTapped.lazyBind { [weak self] in
            let nextVC = ProfileSelectedImageViewController()
            nextVC.viewModel = self?.viewModel
            self?.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        viewModel.outputProfileSuccessButton.bind { [weak self] isEnabled in
            self?.profileSetiingView.configureSuccessButtonState(isEnabled: isEnabled)
        }
        
        viewModel.inputProfileSuccessButtonTapped.lazyBind { _ in
            UserDefaults.standard.set(true, forKey: "isOnboarding")
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
            
            let mainVC = MainViewController()
            sceneDelegate.window?.rootViewController = mainVC
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    private func randomSelectedProfileImage(){
        let index = Int.random(in: 0...11)
        let imageName = "profile_\(index)"
        viewModel.outputProfileImage.value = imageName
    }
    
    private func moveSelectProfileImage(){
        viewModel.inputMoveSelectedImageButtonTapped.value = ()
    }
}

//UITextField
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.viewModel.inputNicknameTextfield.value = textField.text
    }
}

extension ProfileSettingViewController: ProfileSettingViewDelegate {
    func didSelectSuccessButton() {
        viewModel.inputProfileSuccessButtonTapped.value = ()
    }
    
    func didSelectMBTIButton(groupIndex: Int, selectedOption: String) {
        viewModel.updateSelectedMBTI(groupIndex: groupIndex, selectedOption: selectedOption)
    }
    
}
