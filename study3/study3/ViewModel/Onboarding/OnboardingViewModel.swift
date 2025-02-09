//
//  OnboardingViewModel.swift
//  study3
//
//  Created by 이상민 on 2/8/25.
//

import Foundation

class OnboardingViewModel{
    let outputNextButtonTapped: Observable<Void?> = Observable(())
    
    init(){
        print("OnboardingViewModel Init")
    }
    
    deinit{
        print("OnboardingViewModel Deinit")
    }
}
