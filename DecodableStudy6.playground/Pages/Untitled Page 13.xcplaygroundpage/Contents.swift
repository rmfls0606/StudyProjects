//: [Previous](@previous)

import Foundation

let list = ["7", "fg", "asd"]

//서브스크립트. subscript..
list[2] //"asd"

let nick = "안녕하세요 반갑습니다"

extension String{
    subscript(idx: Int) -> String?{
        guard (0..<count).contains(idx) else{
            return nil
        }
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
}

nick[2]

struct UserPhoneList {
    var contacts = [
        "01012341234",
        "01033332222",
        "01056785678"
    ]
    
    subscript(idx: Int) -> String{
        get{
            return self.contacts[idx]
        }
        set{
            self.contacts[idx] = newValue
        }
    }
}

let phone = UserPhoneList()
phone[0]
phone[0] = "345"
phone[0]

//: [Next](@next)
