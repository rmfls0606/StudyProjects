//
//  ProfileViewModel.swift
//  study3
//
//  Created by 이상민 on 2/9/25.
//

import Foundation

class ProfileViewModel {
    let inputNicknameTextfield: Observable<String?> = Observable(nil)
    let inputMoveSelectedImageButtonTapped: Observable<Void> = Observable(())
    let inputProfileImageCellTapped: Observable<String?> = Observable(nil)
    
    let ouputNicknameValidResultText: Observable<String?> = Observable(nil)
    let outputProfileImage: Observable<String?> = Observable(nil)
    
    init() {
        print("ProfileViewModel Init")
        inputNicknameTextfield.bind { [weak self] text in
            self?.validation()
        }
    }
    
    deinit {
        print("ProfileViewModel Deinit")
    }
    
    private func validation(){
        guard let text = inputNicknameTextfield.value, !text.isEmpty else{
            ouputNicknameValidResultText.value = nil
            return
        }
        
        guard text.count >= 2, text.count < 10 else {
            ouputNicknameValidResultText.value = "2글자 이상 10글자 미만으로 설정해주세요"
            return
        }
        
        guard !text.contains(where: {"@#$%".contains($0)}) else{
            ouputNicknameValidResultText.value = "닉네임 @, #, $, % 는 포함할 수 없어요"
            return
        }
        
        guard !text.contains(where: {"0123456789".contains($0)}) else{
            ouputNicknameValidResultText.value = "닉네임에 숫자는 포함할 수 없어요"
            return
        }
        
        ouputNicknameValidResultText.value = "사용할 수 있는 닉네임이에요"
    }
}
