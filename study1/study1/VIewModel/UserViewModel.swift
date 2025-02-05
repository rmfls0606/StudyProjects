//
//  UserViewModel.swift
//  study1
//
//  Created by 이상민 on 2/5/25.
//

import Foundation

class UserViewModel{
    var people: Observable<[Person]> = Observable([])
    
    var addFivePersonDataButtonTapped: Observable<Void> = Observable(())
    
    init(){
        self.addFivePersonDataButtonTapped.bind { _ in
            self.people.value = self.addFivePersonData()
        }
    }
    
    func addFivePersonData() -> [Person]{
        return [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    
    
}
