//
//  OnboardingViewModel.swift
//  study3
//
//  Created by 이상민 on 2/8/25.
//

import Foundation

class OnboardingViewModel: BaseViewModel{
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input{
        
    }
    
    struct Output{
        let NextTapped: Observable<Void?> = Observable(())
    }
    
    init(){
        input = Input()
        output = Output()
        
        transform()
        print("OnboardingViewModel Init")

    }
    
    func transform() {

    }
    
    deinit{
        print("OnboardingViewModel Deinit")
    }
}
