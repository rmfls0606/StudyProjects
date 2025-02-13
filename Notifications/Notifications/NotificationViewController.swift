//
//  NotificationViewController.swift
//  Notifications
//
//  Created by 이상민 on 2/13/25.
//

import UIKit
import SnapKit

final class NotificationViewController: UIViewController {
    let requestButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
    }
    
    func configureHierarchy() {
        view.addSubview(requestButton)
    }
    
    func configureLayout() {
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    func configureView() {
        requestButton.backgroundColor = .blue
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    //MARK: - Actions
    @objc
    private func requestButtonClicked(){
        print(#function)
    }
}
