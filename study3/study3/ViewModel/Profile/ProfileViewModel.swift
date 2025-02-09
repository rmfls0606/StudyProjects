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
    
    let ouputNicknameValidResultText: Observable<NicknameValidResult> = Observable(.empty)
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
            ouputNicknameValidResultText.value = .empty
            return
        }
        
        guard text.count >= 2, text.count < 10 else {
            ouputNicknameValidResultText.value = .rangeError
            return
        }
        
        guard !text.contains(where: {"@#$%".contains($0)}) else{
            ouputNicknameValidResultText.value = .incorrectCharacterError
            return
        }
        
        guard !text.contains(where: {"0123456789".contains($0)}) else{
            ouputNicknameValidResultText.value = .containsNumberError
            return
        }
        
        ouputNicknameValidResultText.value = .success
    }
}
