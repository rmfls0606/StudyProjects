//
//  FolderTable.swift
//  NaverShopping
//
//  Created by 이상민 on 3/5/25.
//

import Foundation
import RealmSwift

class FolderTable: Object{
    @Persisted var id: ObjectId
    @Persisted var name: String
    
    @Persisted var wishList: List<WishListTable>
    
    convenience init(name: String){
        self.init()
        self.name = name
    }
}
