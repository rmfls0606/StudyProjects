//
//  FolderViewController.swift
//  SeSAC6Database
//
//  Created by 이상민 on 3/5/25.
//

import UIKit
import SnapKit
import RealmSwift

class FolderViewController: UIViewController {

    let tableView = UITableView()
    
    var list: Results<Folder>! = nil
    let repository: FolderRepositoryProtocol = FolderRepository()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureView()
        configureConstraints()
        list = repository.fetchAllCase()
        dump(list)
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
        let image = UIImage(systemName: "star")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        navigationItem.rightBarButtonItem = item
    }
    
    @objc func rightBarButtonItemClicked(){
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureConstraints() {
         
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension FolderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.id,
            for: indexPath
        ) as! ListTableViewCell
        let data = list[indexPath.row]
        cell.titleLabel.text = data.name
        cell.subTitleLabel.text = "\(data.detail.count)개"
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let data = list[indexPath.row]
        
        let nextVC = FolderDetailViewController()
        nextVC.list = data.detail
        nextVC.id = data.id
        navigationController?
            .pushViewController(nextVC, animated: true)
    }
    
}
