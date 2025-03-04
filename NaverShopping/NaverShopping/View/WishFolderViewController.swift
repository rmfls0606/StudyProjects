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
    
    let repository: FolderTableRepositoryProtocol = FolderTableRepository()
    var list: Results<FolderTable>!
    
    override func configureHierarchy() {
        self.view.addSubview(tableView)
    }
    
    override func configureLayout() {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func configureView() {
        self.view.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WishFolderCell")
        tableView.backgroundColor = .black
//        repository.createItem(name: "할 일")
//        repository.createItem(name: "예약")
//        repository.createItem(name: "쇼핑")
//        repository.createItem(name: "여행")
        
        self.list = repository.fetchAllCase()
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
        
        content.secondaryText = "\(list[indexPath.row].wishList.count)개"
        content.secondaryTextProperties.color = .white
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let data = list[indexPath.row]
        
        let nextVC = WishListViewController()
        nextVC.list = data.wishList
        nextVC.id = data.id
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
