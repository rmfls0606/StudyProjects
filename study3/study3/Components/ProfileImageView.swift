//
//  ProfileImageView.swift
//  study3
//
//  Created by 이상민 on 2/9/25.
//

import UIKit

class ProfileImageView: UIImageView {
    init(borderColor: UIColor? = UIColor(named: "blueColor"), borderWidtth: CGFloat = 3.0){
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
