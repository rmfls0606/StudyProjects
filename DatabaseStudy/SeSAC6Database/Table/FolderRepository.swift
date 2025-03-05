//
//  FolderRepository.swift
//  SeSAC6Database
//
//  Created by 이상민 on 3/5/25.
//

import Foundation
import RealmSwift

protocol FolderRepositoryProtocol{
    func createItem(name: String)
    func fetchAllCase() -> Results<Folder>
}

final class FolderRepository: FolderRepositoryProtocol{
    private let realm = try! Realm()
    
    func createItem(name: String){
        do{
            try realm.write {
                let folder = Folder(name: name)
                realm.add(folder)
            }
        }catch{
            print("폴더 저장 실페")
        }
    }
    
    func fetchAllCase() -> Results<Folder>{
        return realm.objects(Folder.self)
    }
}
