//
//  WishFolderViewController.swift
//  NaverShopping
//
//  Created by 이상민 on 3/5/25.
//

import UIKit
import SnapKit
import RealmSwift

class WishFolderViewController: BaseViewController {
    
    private let tableView = UITableView()
    
    private let realm = try! Realm()
    var list: Results<FolderTable>!
    
    override func configureHierarchy() {
        self.view.addSubview(tableView)
    }
    
    override func configureLayout() {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        self.view.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WishFolderCell")
        tableView.backgroundColor = .black
        addWhishFolder(folderName: "할 일")
        addWhishFolder(folderName: "예약")
        addWhishFolder(folderName: "쇼핑")
        addWhishFolder(folderName: "여행")
        
        self.list = realm.objects(FolderTable.self)
    }
    
    func addWhishFolder(folderName: String){
        do{
            try realm.write {
                let folder = FolderTable(name: folderName)
                realm.add(folder)
            }
        }catch{
            print("위시폴더 생성 실패")
        }
    }
}

extension WishFolderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "WishFolderCell",
            for: indexPath
        )
    
        var content = cell.defaultContentConfiguration()
        content.text = list[indexPath.row].name
        content.textProperties.color = .white
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        
        return cell
    }

    
}
