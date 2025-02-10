//
//  Observable.swift
//  study4
//
//  Created by 이상민 on 2/10/25.
//

import Foundation

class Observable<T>{
    var closure: ((T) -> Void)?
    var value: T{
        didSet{
            closure?(value)
        }
    }
    
    init(_ value: T){
        self.value = value
    }
    
    func bind(closure: @escaping ((T) -> Void)){
        closure(value)
        self.closure = closure
    }
    
    func lazyBind(closure: @escaping ((T) -> Void)){
        self.closure = closure
    }
}
