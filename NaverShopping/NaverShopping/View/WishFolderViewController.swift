//
//  WishFolderViewController.swift
//  NaverShopping
//
//  Created by 이상민 on 3/5/25.
//

import UIKit
import SnapKit

class WishFolderViewController: BaseViewController {
    
    private let tableView = UITableView()
    
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
    }
    
    override func configureBind() {
        
    }
}

extension WishFolderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "WishFolderCell",
            for: indexPath
        )
    
        var content = cell.defaultContentConfiguration()
        content.text = "Wish Folder"
        content.textProperties.color = .white
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        
        return cell
    }

    
}
