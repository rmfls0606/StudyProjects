//
//  ProfileSelectedImageViewController.swift
//  study3
//
//  Created by 이상민 on 2/9/25.
//

import UIKit
import SnapKit

class ProfileSelectedImageViewController: UIViewController {
    private let profileSelectedImageview = ProfileSelectedImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setLayout()
    }
    
    private func setUI() {
        self.view.addSubview(profileSelectedImageview)
    }
    
    private func setLayout() {
        self.profileSelectedImageview.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
