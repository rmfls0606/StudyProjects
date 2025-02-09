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
    
    init(borderColor: UIColor? = UIColor(named: "lightGrayColor"), borderWidtth: CGFloat = 1.0){
        super.init(frame: .zero)
        configure(borderColor: borderColor, borderwidtth: borderWidtth)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure(borderColor: UIColor? , borderwidtth: CGFloat){
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderwidtth
    }
}
