//: [Previous](@previous)

import Foundation

struct JackDefaults{
    let key: String
    let empty: String
    
    var myValue: String{
        get{
            UserDefaults.standard.string(forKey: key) ?? empty
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

//: [Next](@next)
