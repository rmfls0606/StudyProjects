//
//  ProfileSelectedImageCell.swift
//  study3
//
//  Created by 이상민 on 2/9/25.
//

import UIKit
import SnapKit

class ProfileSelectedImageCell: BaseCollectionViewCell {
    static let identifier = "ProfileSelectedImageCell"
    
    private let imageView = ProfileImageView()
    
    override func configureHierarchy() {
        self.addSubview(imageView)
    }
    
    override func configureLayout() {
        self.imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureImage(imageName: String){
        let image = UIImage(named: imageName)
        self.imageView.image = image
    }
}
