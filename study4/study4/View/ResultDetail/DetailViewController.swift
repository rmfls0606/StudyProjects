//
//  DetailViewController.swift
//  PhotoSearchAPI
//
//  Created by 이상민 on 1/22/25.
//

import UIKit
import Kingfisher
import SnapKit

class DetailViewController: UIViewController {
    
//    var item: SearchResult?
//    private var statisticsData: StatisticsResponse? = nil
    private let resultDetailView = ResultDetailView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
//        callRequest(id: item!.id)
    }
    
    private func setUI(){
        self.view.backgroundColor = .white
        self.view.addSubview(resultDetailView)
    }
    
    private func setLayout(){
        self.resultDetailView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
//    private func callRequest(id: String){
//        let url = "https://api.unsplash.com/photos/\(id)/statistics?"
//        
//        let parametr: [String: Any] = [
//            "client_id": ApiKey.client_ID
//        ]
//        
//        NetworkManager.shared.loadData(url: url,
//                                       method: .get,
//                                       parameters: parametr,
//                                       completion: {(result: Result<StatisticsResponse, Error>) in
//            switch result {
//            case .success(let success):
//                self.statisticsData = success
//                self.viewsValueLabel.text = success.views.total.formatted(.number)
//                self.downloadsValueLabel.text = success.downloads.total.formatted(.number)
//            case .failure(let failure):
//                fatalError(failure.localizedDescription)
//            }
//        })
//    }
}
