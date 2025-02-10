//
//  ProfileViewModel.swift
//  study3
//
//  Created by 이상민 on 2/9/25.
//

import Foundation

class ProfileViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input{
        let nickname: Observable<String?> = Observable(nil)
        let moveSelectedImageTapped: Observable<Void> = Observable(())
        let profileImageTapped: Observable<String?> = Observable(nil)
        let selectedMBTIButtons: Observable<[String]> = Observable(["","","",""])
        let profileSuccessTapped: Observable<Void> = Observable(())
    }
    
    struct Output{
        let nicknameValidResultText: Observable<NicknameValidResult> = Observable(.empty)
        let profileImage: Observable<String?> = Observable(nil)
        let profileSuccessButton: Observable<Bool> = Observable(false)
    }

    init() {
        input = Input()
        output = Output()
        
        transform()
        print("ProfileViewModel Init")
    }
    
    func transform() {
        input.nickname.bind { [weak self] text in
            self?.validation()
        }
    }
    
    deinit {
        print("ProfileViewModel Deinit")
    }
    
    private func validation(){
        guard let text = input.nickname.value, !text.isEmpty else{
            output.nicknameValidResultText.value = .empty
            return
        }
        
        guard text.count >= 2, text.count < 10 else {
            output.nicknameValidResultText.value = .rangeError
            return
        }
        
        guard !text.contains(where: {"@#$%".contains($0)}) else{
            output.nicknameValidResultText.value = .incorrectCharacterError
            return
        }
        
        guard !text.contains(where: {"0123456789".contains($0)}) else{
            output.nicknameValidResultText.value = .containsNumberError
            return
        }
        
        output.nicknameValidResultText.value = .success
    }
    
    func updateSelectedMBTI(groupIndex: Int, selectedOption: String){
        var updateMBTI = input.selectedMBTIButtons.value
        updateMBTI[groupIndex] = selectedOption
        input.selectedMBTIButtons.value = updateMBTI
        profleSuccessEnable()
    }
    
    func profleSuccessEnable(){
        if output.nicknameValidResultText.value == .success && !input.selectedMBTIButtons.value.contains(""){
            output.profileSuccessButton.value = true
        }else{
            output.profileSuccessButton.value = false
        }
    }
}
