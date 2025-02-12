//: [Previous](@previous)

import Foundation

enum UserDefaultsManager {
    
    enum Key: String {
        case email
        case nickname
        case phone
    }

    static var email: String {
        get {
            UserDefaults.standard.string(forKey: Key.email.rawValue) ?? "이메일 없음"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.email.rawValue)
        }
    }
    
    static var nickname: String {
        get {
            UserDefaults.standard.string(forKey: Key.nickname.rawValue) ?? "닉네임 없음"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.nickname.rawValue)
        }
    }
}
//: [Next](@next)
