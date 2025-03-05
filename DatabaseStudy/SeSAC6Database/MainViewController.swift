//
//  MainViewController.swift
//  SeSAC6Database
//
//  Created by Jack on 3/4/25.
//

import UIKit
import SnapKit
import RealmSwift

class MainViewController: UIViewController {

    let tableView = UITableView()
    
    var list: Results<Table>!
     
    let repository: RespositoryProtocol = TableRepository()
//    let folderRepository: FolderRepositoryProtocol = FolderRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        folderRepository.createItem(name: "개인")
//        folderRepository.createItem(name: "계모임")
//        folderRepository.createItem(name: "회사")
//        folderRepository.createItem(name: "멘토")
        
        print(#function)
        configureHierarchy()
        configureView()
        repository.getFileURL()
        configureConstraints()
        
        list = repository.fetchAllCase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        tableView.reloadData()
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
          
        let image = UIImage(systemName: "plus")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        navigationItem.rightBarButtonItem = item
    }
    
    private func configureConstraints() {
         
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
     
    @objc func rightBarButtonItemClicked() {
        let vc = AddViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
        
        let data = list[indexPath.row]
        
        cell.titleLabel.text = data.product
        cell.subTitleLabel.text = data.categoryName
        cell.overviewLabel.text = data.money.formatted()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        repository.updateItem(data: data) //Realm write
        tableView.reloadData()
    }
      
    
}
