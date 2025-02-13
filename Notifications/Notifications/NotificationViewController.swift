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
        content.title = "Identifier의미 확인해보기"
        content.subtitle = "\(Int.random(in: 1...10000))"
        
        //1. timeInterval
        //박복이 왜 필요할까?
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 60,
            repeats: true
        )
        
        let request = UNNotificationRequest.init(identifier: "\(Date())",
                                   content: content,
                                   trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
        
        //Notification 2. Foreground 수신을 위한 delegate 설정
        UNUserNotificationCenter.current().delegate = self
    }
}

extension NotificationViewController: UNUserNotificationCenterDelegate{
    
    //Notification 2. 포그라운드 수신
    //ex. 친구랑 1:1 채팅하는 경우, 당사자 푸시는 안옴. 다른 다톡방/갠톡방 등이나 푸시가 오는 것처럼, 특정 화면/조건에 대해서 Foreground에서 알림을 받는 것이 가능
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (
            UNNotificationPresentationOptions
        ) -> Void
    ) {
        completionHandler([.banner, .badge, .list, .sound])
    }
}
