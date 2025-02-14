//: [Previous](@previous)

import Foundation

//struct -> Data -> String -> Server
struct User: Encodable{
    let name: String
    let age: Int
    let birth: Date
}
    
let jack = [
        User(name: "잭", age: 12, birth: Date(timeIntervalSinceNow: 86400 * 2)),
        User(name: "브렌", age: 88, birth: Date(timeIntervalSinceNow: 86400 * 2)),
        User(name: "덴", age: 1, birth: Date(timeIntervalSinceNow: 86400 * 2))
    ]
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
//encoder.dateEncodingStrategy
//encoder.keyEncodingStrategy
//encoder.outputFormatting



//encoder.dateEncodingStrategy = .iso8601
let format = DateFormatter()
format.dateFormat = "MM월 dd일, yyyy년"

encoder.dateEncodingStrategy = .formatted(format)


//Router Pattern
struct SearchQuery{
    let page: Int
    let language: String
}

//["page": 1, "language": "ko-KR"]

do{
    let result = try encoder.encode(jack)
    print(result)
    
    guard let jsonString = String(data: result, encoding: .utf8) else{
        fatalError("ERROR")
    }
    
    
    print(jsonString)
}catch{
    print(error)
}


//:[Next](@next)
