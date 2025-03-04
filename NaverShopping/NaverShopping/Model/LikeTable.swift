//
//  LikeTable.swift
//  NaverShopping
//
//  Created by 이상민 on 3/4/25.
//

import Foundation
import RealmSwift

class LikeTable: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var imageNamge: String
    @Persisted var productName: String
    @Persisted var productContent: String
    @Persisted var price: String
    
    convenience init(
        id: String,
        imageNamge: String,
        productName: String,
        productContent: String,
        price: String
    ) {
        self.init()
        self.id = id
        self.imageNamge = imageNamge
        self.productName = productName
        self.productContent = productContent
        self.price = price
    }
}


