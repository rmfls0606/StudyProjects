//: [Previous](@previous)

import Foundation

@propertyWrapper
struct Decimal{
    var money: String
    
    var projectedValue = ""
    
    var wrappedValue: String{
        get{
            return Int(money)!.formatted(.number) + "원"
        }
        set{
            money = newValue
            projectedValue = "당신이 이체한 금액은 \(newValue)입니다."
        }
    }
}

//@Decimal() //wrappedValue만 가져올 수 있게 하기 위해서 @를 붙힌다.

struct Example{
    
    @Decimal(money: "7000") var number
}

var example = Example()

example.number
example.$number
example.number = "8423689000"
example.number
example.$number



//: [Next](@next)
