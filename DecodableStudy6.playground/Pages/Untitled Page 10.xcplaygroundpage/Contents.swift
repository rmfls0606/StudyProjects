//: [Previous](@previous)

import Foundation

struct JackDefaults<T>{
    let key: String
    let empty: T
    
//    let age = UserDefaults.standard.object(forKey: "age") as? Int ?? 0
    
    var myValue: T{
        get{
            UserDefaults.standard.object(forKey: key) as? T ?? empty
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}
var nick = JackDefaults(key: "nick", empty: "손님")
var phone = JackDefaults(key: "age", empty: "0")

nick.myValue = "고래밥"
nick.myValue

phone.myValue = "12345"
phone.myValue



age.myValue
first.myValue
nick.myValue

enum UserDefaultsManager{
    enum key: String {
        case email, nickname, phone
    }
    static var age = JackDefaults(key: key.age.rawValue, empty: 16)
    static var first = JackDefaults(key:  key.first.rawValue, empty: false)
    static var nick = JackDefaults(key:  key.nick.rawValue, empty: "고래밥")
}


//vc
//enum struct 구조에서 항상 myValue를 호출해야 하는 부분이 아쉬움.
UserDefaultsManager.age.myValue
UserDefaultsManager.age.myValue = 89
UserDefaultsManager.age.myValue

UserDefaultsManager.age //89 이렇게 나왔으면 좋겠다
//: [Next](@next)
