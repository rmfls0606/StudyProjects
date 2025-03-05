//
//  TableRepository.swift
//  SeSAC6Database
//
//  Created by 이상민 on 3/5/25.
//

import Foundation
import RealmSwift

protocol RespositoryProtocol{
    func getFileURL()
    func fetchAllCase() -> Results<Table>
    func createItem()
    func deleteItem(data: Table)
    func updateItem(data: Table)
}

//Realm CRUD
final class TableRepository: RespositoryProtocol{
    private let realm = try! Realm() //default.realm
    
    func getFileURL(){
        print(realm.configuration.fileURL)
    }
    
    func fetchAllCase() -> Results<Table>{
        let data = realm.objects(Table.self)
            .sorted(byKeyPath: "money", ascending: false)
        
        return data
    }
    
    func createItem(){
        //Create
        do{
            try realm.write {
                
                let data = Table(
                    money: .random(in: 100...1000) * 100,
                    categoryName: ["생활비", "카페", "식비"].randomElement()!,
                    product: ["린스", "커피", "과자", "칼국수"].randomElement()!,
                    incomeOrExpense: false,
                    memo: nil
                )
                
                realm.add(data)
                print("앰 저장 완료")
            }
        }catch{
            print("램에 저장이 실패한 경우")
        }
    }
    
    func deleteItem(data: Table){
        do{
            try realm.write {
                realm.delete(data)
            }
        }catch{
            print("렘 데이터 삭제 실패")
        }
    }
    
    func updateItem(data: Table){
        do{
            try realm.write {
                
                realm.create(Table.self, value: [
                    "id": data.id,
                    "money": 1000000
                ], update: .modified)
            }
        }catch{
            print("렘 데이터 수정 실패")
        }
    }
}
