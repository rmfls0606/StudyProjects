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
    let inputSelectedMBTIButtons: Observable<[String]> = Observable(["","","",""])
    let inputProfileSuccessButtonTapped: Observable<Void> = Observable(())
    
    let outputNicknameValidResultText: Observable<NicknameValidResult> = Observable(.empty)
    let outputProfileImage: Observable<String?> = Observable(nil)
    let outputProfileSuccessButton: Observable<Bool> = Observable(false)
    
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
            outputNicknameValidResultText.value = .empty
            return
        }
        
        guard text.count >= 2, text.count < 10 else {
            outputNicknameValidResultText.value = .rangeError
            return
        }
        
        guard !text.contains(where: {"@#$%".contains($0)}) else{
            outputNicknameValidResultText.value = .incorrectCharacterError
            return
        }
        
        guard !text.contains(where: {"0123456789".contains($0)}) else{
            outputNicknameValidResultText.value = .containsNumberError
            return
        }
        
        outputNicknameValidResultText.value = .success
    }
    
    func updateSelectedMBTI(groupIndex: Int, selectedOption: String){
        var updateMBTI = inputSelectedMBTIButtons.value
        updateMBTI[groupIndex] = selectedOption
        inputSelectedMBTIButtons.value = updateMBTI
        profleSuccessEnable()
    }
    
    func profleSuccessEnable(){
        if outputNicknameValidResultText.value == .success && !inputSelectedMBTIButtons.value.contains(""){
            outputProfileSuccessButton.value = true
        }else{
            outputProfileSuccessButton.value = false
        }
    }
}
