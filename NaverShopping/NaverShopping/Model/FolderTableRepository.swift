//
//  FolderTableRepository.swift
//  NaverShopping
//
//  Created by 이상민 on 3/6/25.
//

import Foundation
import RealmSwift

protocol FolderTableRepositoryProtocol{
    func createItem(name: String)
    func fetchAllCase() -> Results<FolderTable>
}

final class FolderTableRepository: FolderTableRepositoryProtocol{
    private let realm = try! Realm()
    
    func createItem(name: String){
        do{
            try realm.write {
                let folder = FolderTable(name: name)
                realm.add(folder)
            }
        }catch{
            print("위시폴더 생성 실패")
        }
    }
    
    func fetchAllCase() -> Results<FolderTable>{
        return realm.objects(FolderTable.self)
    }
}
