//
//  MulitiSectionViewController.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/25/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

struct Mentor{//섹션
    let name: String //섹션 타이틀 ex. Jack, Den, Bran
    var items: [Item] //섹션 내에 셀에 들어갈 정보 ex.
    
}

extension Mentor: SectionModelType{
    typealias Item = String
    
    init(original: Mentor, items: [Item]) {
        self = original
        self.items = items
    }
}

class MulitiSectionViewController: UIViewController {

    let tableView = UITableView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        //1. TableViewSectionedDataSource<SectionModelType>
        //4. SectionModelType.Item
//        let dataSource = RxTableViewSectionedReloadDataSource<Mentor> {
// dataSource,
// tableView,
//            indexPath,
//            item in
//            
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: "sectionCell",
//                for: indexPath
//            )
//            
//            cell.textLabel?.text = item
//            return cell
//        }
        
        let dataSource: RxTableViewSectionedReloadDataSource<Mentor> =
        RxTableViewSectionedReloadDataSource{
            dataSource,
            tableView,
            indexPath,
            item in
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "sectionCell",
                for: indexPath
            )
            
            cell.textLabel?.text = item
            return cell
        }
        
        dataSource.titleForHeaderInSection = {dataSource, index in
            return dataSource.sectionModels[index].name
        }
        
        let mentor = [
            Mentor(name: "Jack", items: [
                "맛점하셨나요?", "다시해볼까요?", "가보겠습니다", "자 과제 나갑니다", "진짠데", "돌아오세요", "저는 여러분이 고생했으면 좋겠어요"
            ]),
            Mentor(name: "Den", items: [
                "정답은 업죠", "그건 00님이 찾아보고 알려주세요", "스스로 해보시고", "로그 찍어보세요", "화이팅"
            ]),
            Mentor(name: "Bran", items: [
                "잘 되시나요"
            ])
        ]
        
        Observable.just(mentor)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func configure(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sectionCell")
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
