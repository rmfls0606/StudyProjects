//
//  SimpleTableViewCell.swift
//  RxSwiftStudy
//
//  Created by 이상민 on 2/19/25.
//

import UIKit
import SnapKit

class SimpleTableViewCell: UITableViewCell {
    
    static let identifier = "SimpleTableViewCell"
    
    let title:  UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
        setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
        setLayout()
        setView()
    }
    
    func setUI() {
        self.contentView.addSubview(title)
    }
    
    func setLayout(){
        self.title.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(14)
        }
    }
    
    func setView() {
        self.selectionStyle = .none
        self.accessoryType = .detailButton
    }
}
