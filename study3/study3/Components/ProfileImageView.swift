//
//  ProfileImageView.swift
//  study3
//
//  Created by 이상민 on 2/9/25.
//

import UIKit

class ProfileImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    init(){
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.borderColor = UIColor(named: "blueColor")?.cgColor
        self.layer.borderWidth = 3.0
    }
}
