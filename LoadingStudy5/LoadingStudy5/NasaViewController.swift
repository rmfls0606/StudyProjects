//
//  NasaViewController.swift
//  LoadingStudy5
//
//  Created by 이상민 on 2/11/25.
//

import UIKit
import SnapKit

class NasaViewController: UIViewController {
    let requestButton = UIButton()
    let progressLabel = UILabel()
    let nasaImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(requestButton)
        view.addSubview(progressLabel)
        view.addSubview(nasaImageView)
    }
    
    func configureLayout() {
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(requestButton.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        nasaImageView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(progressLabel.snp.bottom).offset(20)
        }
    }
    
    func configureView() {
        requestButton.backgroundColor = .blue
        progressLabel.backgroundColor = .white
        progressLabel.text = "100% 중 0% 완료"
        nasaImageView.backgroundColor = .systemBrown
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    @objc
    private func requestButtonClicked(){
        print(#function)
    }
}
