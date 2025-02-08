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
        setLogic()
    }
    
    private func setUI() {
        self.view.addSubview(profileSelectedImageview)
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "PROFILE SETTING"
    }
    
    private func setLayout() {
        self.profileSelectedImageview.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setLogic(){
        self.profileSelectedImageview.configureDelegate(delegate: self, dataSource: self)
    }
}

extension ProfileSelectedImageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileSelectedImageCell.identifier, for: indexPath) as? ProfileSelectedImageCell else {
            return UICollectionViewCell()
        }
        let imageName = "profile_\(indexPath.item)"
        cell.configureImage(imageName: imageName)
        return cell
    }
    
    
}
