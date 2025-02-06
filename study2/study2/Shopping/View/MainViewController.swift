//
//  MainViewController.swift
//  FourthApp
//
//  Created by 이상민 on 1/15/25.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = UIColor(named: "searchBarbc")
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: searchBar.placeholder!, attributes: [.foregroundColor: UIColor.lightGray])
        searchBar.searchTextField.textColor = .lightGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        
        searchBar.delegate = self
        return searchBar
    }()
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setBind()
    }
    
    private func setUp(){
        self.navigationItem.title = "도봉러의 쇼핑쇼핑"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.view.backgroundColor = .black
        
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setBind(){
        viewModel.inputSearchBarReturnButtonTapped.lazyBind { [weak self] text in
            let nextVC = SearchDetailViewController()
            nextVC.viewModel.outputSearchText.value = text
            self?.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension MainViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        guard let query = searchBar.text, query.count >= 2 else{
            showAlert(title: "검색 실패", message: "2글자 이상 검색어를 입력해주세요.") {
                print("2글자 이상 입력해주세요.")
            }
            return
        }
        // TODO: 2글자 이하면 alert 나오게 하기
        viewModel.inputSearchBarReturnButtonTapped.value = query
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
}

extension MainViewController{
    func showAlert(title: String,
                   message: String,
                   okAction: @escaping () -> Void){
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default) { _ in
            okAction()
        }
        alert.addAction(okButton)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true)
    }
}
