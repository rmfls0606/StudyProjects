//
//  SimpleTableViewExampleViewController.swift
//  RxSwiftStudy
//
//  Created by 이상민 on 2/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimpleTableViewExampleViewController: UIViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    let items = Observable.just(
        (0..<27).map{ "\($0)번째 IndexCell"}
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setView()
        bind()
    }
    
    func setUI(){
        self.view.addSubview(tableView)
    }
    
    func setLayout(){
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func setView(){
        self.view.backgroundColor = .white
    }
    
    func bind(){
        items
            .bind(to: tableView.rx.items){ (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.identifier) as! SimpleTableViewCell
                cell.title.text = element
                return cell
            }
            .disposed(by: disposeBag)
    }
}
