//: [Previous](@previous)

import Foundation

//struct -> Data -> String -> Server
struct User{
    let name: String
    let age: Int
}
    
let jack = User(name: "잭", age: 12)
let encoder = JSONEncoder()
//encoder.dateEncodingStrategy
//encoder.keyEncodingStrategy
//encoder.outputFormatting

//Router Pattern
struct SearchQuery{
    let page: Int
    let language: String
}

//["page": 1, "language": "ko-KR"]



//:[Next](@next)
