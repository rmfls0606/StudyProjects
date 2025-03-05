//
//  Folder.swift
//  SeSAC6Database
//
//  Created by 이상민 on 3/5/25.
//

import Foundation
import RealmSwift

//n개의 테이블
class Folder: Object{
    @Persisted var id: ObjectId
    @Persisted var name: String
    
    //1:n, to many rlationship
    @Persisted var detail: List<Table>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
