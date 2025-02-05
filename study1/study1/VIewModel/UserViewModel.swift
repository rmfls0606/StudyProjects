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
    var removeAllPersonDataButtonTapped: Observable<Void> = Observable(())
    var addOnePersonDataButtonTapped: Observable<Void> = Observable(())
    
    init(){
        self.addFivePersonDataButtonTapped.bind { _ in
            self.people.value = self.addFivePersonData()
        }
        
        self.addOnePersonDataButtonTapped.bind { _ in
            self.people.value.append(contentsOf: self.addOnePersonData())
        }
        
        self.removeAllPersonDataButtonTapped.bind { _ in
            self.people.value = self.removeAllPersonData()
        }
    }
    
    private func addFivePersonData() -> [Person]{
        return PersonDummyData.DummyData
    }
    
    private func removeAllPersonData() -> [Person]{
        return []
    }
    
    private func addOnePersonData() -> [Person]{
        return [PersonDummyData.DummyData.randomElement()!]
    }
}
