//
//  NicknameValidResult.swift
//  study3
//
//  Created by 이상민 on 2/10/25.
//

import Foundation

enum NicknameValidResult {
    case success
    case empty
    case rangeError
    case incorrectCharacterError
    case containsNumberError
    
    var description: String {
        switch self {
        case .success:
            return "사용할 수 있는 닉네임이에요"
        case .empty:
            return ""
        case .rangeError:
            return "2글자 이상 10글자 미만으로 설정해주세요"
        case .incorrectCharacterError:
            return "닉네임 @, #, $, % 는 포함할 수 없어요"
        case .containsNumberError:
            return "닉네임에 숫자는 포함할 수 없어요"
        }
    }
}
