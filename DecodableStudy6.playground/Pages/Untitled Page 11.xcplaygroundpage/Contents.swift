//: [Previous](@previous)

import Foundation
/*
 @propertyWrapper
 - wrappedValue
 - projectedValue(option)
 */

@propertyWrapper struct JackDefaults<T>{
    let key: String
    let empty: T
    
    private(set) var projectValue: Bool
    
    var wrappedValue: T{ //무조건 호출
        get{
            UserDefaults.standard.object(forKey: key) as? T ?? empty
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}

enum UserDefaultsManager{
    enum key: String {
        case email, nickname, phone
    }
    @JackDefaults(key: key.age.rawValue, empty: 16)
    static var age
    
    @JackDefaults(key:  key.first.rawValue, empty: false)
    static var first
    
    @JackDefaults(key:  key.nick.rawValue, empty: "고래밥")
    static var nick
}


//vc
//enum struct 구조에서 항상 myValue를 호출해야 하는 부분이 아쉬움.
UserDefaultsManager.age
UserDefaultsManager.age = 89
UserDefaultsManager.age

UserDefaultsManager.age //89 이렇게 나왔으면 좋겠다
UserDefaultsManager.nick //weappedValue
UserDefaultsManager.$nick //projectedValue: 래퍼의 부가적인 상태를 외부에 보여주려고 할 때
//: [Next](@next)
