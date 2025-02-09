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
    
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setLayout()
        setLogic()
        setBind()
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
        
        if let imageName = viewModel?.outputProfileImage.value{
            self.profileSelectedImageview.configureImage(imageName: imageName)
        }
    }
    
    private func setBind(){
        viewModel?.inputProfileImageCellTapped.lazyBind { [weak self] imageName in
            self?.profileSelectedImageview.configureImage(imageName: imageName!)
            self?.viewModel?.outputProfileImage.value = imageName
            self?.profileSelectedImageview.relodaData()
        }
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
        if imageName == viewModel?.outputProfileImage.value{
            cell.configureImage(imageName: imageName, isSelected: true)
        }else{
            cell.configureImage(imageName: imageName, isSelected: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel?.inputProfileImageCellTapped.value = "profile_\(indexPath.item)"
    }
    
    
}
