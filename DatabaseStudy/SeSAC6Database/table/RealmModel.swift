//
//  RealmModel.swift
//  SeSAC6Database
//
//  Created by 이상민 on 3/4/25.
//

import Foundation
import RealmSwift

class Table: Object {
    //금액
    @Persisted var money: Int
    //카테고리명
    @Persisted var categoryName: String
    //상품명
    @Persisted var product: String
    //수입지출여부
    @Persisted var incomeOrExpense: Bool
    //메모
    @Persisted var memo: String?
    //등록일
    @Persisted var uploadDate: Date
    
    
    convenience init(money: Int, categoryName: String, product: String, incomeOrExpense: Bool, memo: String?) {
        self.init()
        self.money = money
        self.categoryName = categoryName
        self.product = product
        self.incomeOrExpense = incomeOrExpense
        self.memo = memo
        self.uploadDate = Date()
    }
}
