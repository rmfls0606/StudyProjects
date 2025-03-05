//
//  WishListTable.swift
//  NaverShopping
//
//  Created by 이상민 on 3/5/25.
//

import Foundation
import RealmSwift

class WishListTable: Object{
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var wishListText: String
    
    convenience init(wishListText: String){
        self.init()
        self.wishListText = wishListText
    }
}
