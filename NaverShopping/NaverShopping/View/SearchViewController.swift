//
//  SearchViewController.swift
//  NaverShopping
//
//  Created by 이상민 on 2/25/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    private let viewModel: SearchViewModel
    private let disposeBag = DisposeBag()
    
    init(query: String){
        self.viewModel = SearchViewModel(query: query)
        super.init(nibName: nil, bundle: nil)
        self.title = query
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureLayout() {
        
    }
    
    override func configureView() {
        self.view.backgroundColor = .red
    }
}
