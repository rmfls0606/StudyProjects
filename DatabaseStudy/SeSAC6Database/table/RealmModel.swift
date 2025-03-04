//
//  RealmModel.swift
//  SeSAC6Database
//
//  Created by 이상민 on 3/4/25.
//

import Foundation
import RealmSwift

class Table: Object {
    //기본키, 중복x, 비어x
    //Index기능 기본으로 가지고 있음
    @Persisted(primaryKey: true) var id: ObjectId
    //금액
    @Persisted var money: Int
    //카테고리명
    @Persisted var categoryName: String
    
    //상품명
    @Persisted(indexed: true) var product: String //인덱스 기준으로 하여 더 빠르게 찾을 수 있게 할 수 있따.
    //수입지출여부
    @Persisted var incomeOrExpense: Bool
    //메모
    @Persisted var memo: String?
    //등록일
    @Persisted var uploadDate: Date
    //좋아요
    @Persisted var like: Bool
    
    
    convenience init(
        money: Int,
        categoryName: String,
        product: String,
        incomeOrExpense: Bool,
        memo: String?,
        like: Bool = false
    ) {
        self.init()
        self.money = money
        self.categoryName = categoryName
        self.product = product
        self.incomeOrExpense = incomeOrExpense
        self.memo = memo
        self.uploadDate = Date()
    }
}

//n개의 테이블
class Folder: Object{
    @Persisted var name: String
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
