//
//  WishListTableRepository.swift
//  NaverShopping
//
//  Created by 이상민 on 3/6/25.
//

import Foundation
import RealmSwift

protocol WishListTableRespositoryProtocol{
    func getFileURL()
    func fetchAllCase() -> Results<WishListTable>
    func createItem(text: String)
    func deleteItem(data: WishListTable)
    func createItemInFolder(folder: FolderTable, text: String)
}

//Realm CRUD
final class WishListTableRepository: WishListTableRespositoryProtocol{
    private let realm = try! Realm() //default.realm
    
    func getFileURL(){
        print(realm.configuration.fileURL)
    }
    
    func fetchAllCase() -> Results<WishListTable>{
        let data = realm.objects(WishListTable.self)
            .sorted(byKeyPath: "money", ascending: false)
        
        return data
    }
    
    func createItemInFolder(folder: FolderTable, text: String){
        //Create
        do{
            try realm.write {
                
                //어떤 폴더에 넣어줄 지
//                let folder = realm.objects(Folder.self).where{
//                    $0.name == "개인"
//                }.first!
                
                let data = WishListTable(wishListText: text)
                
                folder.wishList.append(data)
                realm.add(data)
                print("앰 저장 완료")
            }
        }catch{
            print("램에 저장이 실패한 경우")
        }
    }
    
    func createItem(text: String){ //Folder 테이블과 상관업이 Table에 레코드 바로 추가
        //Create
        do{
            try realm.write {
                
                let data = WishListTable(wishListText: text)
                
                realm.add(data)
                print("앰 저장 완료")
            }
        }catch{
            print("램에 저장이 실패한 경우")
        }
    }
    
    func deleteItem(data: WishListTable){
        do{
            try realm.write {
                realm.delete(data)
            }
        }catch{
            print("렘 데이터 삭제 실패")
        }
    }
}

