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
    
    let viewModel = ResultDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setBind()
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
    
    private func setBind(){
        self.viewModel.output.resultStatistics.bind { [weak self] response in
            guard let searchResult = self?.viewModel.output.searchResult.value,
                    let resultStatistic = response else { return }
            
            self?.resultDetailView.configreData(searchResult: searchResult, resultStatistics: resultStatistic)
        }
    }
}
