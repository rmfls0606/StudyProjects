//
//  CompositionCollectionViewCell.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/27/25.
//

import UIKit
import SnapKit

class CompositionCollectionViewCell: UICollectionViewCell {
    let label = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.textColor = .brown
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
