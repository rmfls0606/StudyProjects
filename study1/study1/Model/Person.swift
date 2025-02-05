//
//  Person.swift
//  study1
//
//  Created by 이상민 on 2/5/25.
//

import Foundation

struct Person {
    let name: String
    let age: Int
}

struct PersonDummyData{
    static let DummyData: [Person] = [
        Person(name: "James", age: Int.random(in: 20...70)),
        Person(name: "Mary", age: Int.random(in: 20...70)),
        Person(name: "John", age: Int.random(in: 20...70)),
        Person(name: "Patricia", age: Int.random(in: 20...70)),
        Person(name: "Robert", age: Int.random(in: 20...70))
    ]
}
