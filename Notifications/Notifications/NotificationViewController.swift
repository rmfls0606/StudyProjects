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
        configureHierarchy()
        configureLayout()
        configureView()
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
        
        let content = UNMutableNotificationContent()
        content.title = "테스트 userinfo 활용"
        content.subtitle = "\(Int.random(in: 1...10000))"
        content.badge = 35
        content.userInfo = ["type": 2, "id": 46563]
        
        //1. timeInterval
        //박복이 왜 필요할까?
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 3,
            repeats: false
        )
        
        //        var componenets = DateComponents()
        //        componenets.day = 14
        //        componenets.hour = 11
        //        componenets.minute = 45
        //
        //        //2. calendar
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: componenets,
        //                                                    repeats: false)
        
        let request = UNNotificationRequest.init(identifier: "\(Date())",
                                                 content: content,
                                                 trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
    }
}
