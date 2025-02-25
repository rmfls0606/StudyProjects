//
//  SortButtonView.swift
//  UpDownGame
//
//  Created by 이상민 on 1/16/25.
//

import UIKit
import SnapKit

protocol SortButtonDelegate: AnyObject{
    func sortButtonTapped(_ sender: SortButtonView)
}

class SortButtonView: BaseView{
    private lazy var sortButtonView = UIButton()
    
    weak var delegate: SortButtonDelegate?
    
    var isSelected: Bool = false{
        didSet{
            if isSelected{
                self.backgroundColor = .white
                self.sortButtonView.setTitleColor(.black, for: .normal)
                self.sortButtonView.setTitleColor(.black, for: .highlighted)
            }else{
                self.backgroundColor = .black
                self.sortButtonView.setTitleColor(.white, for: .normal)
                self.sortButtonView.setTitleColor(.white, for: .highlighted)
            }
        }
    }
    
    init(text: String){
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
        configureView()
        configureData(text: text)
    }
    
    override func configureHierarchy() {
        self.addSubview(sortButtonView)
    }
    
    
    override func configureLayout() {
        self.backgroundColor = .black
        
        sortButtonView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.backgroundColor = .black
        
        self.sortButtonView.setTitleColor(.white, for: .normal)
        self.sortButtonView.setTitleColor(.white, for: .highlighted)
        self.sortButtonView.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    func configureData(text:String){
        sortButtonView.setTitle(text, for: .normal)
        sortButtonView.setTitle(text, for: .highlighted)
    }
    
    @objc
    func sortButtonTapped(_ sender: UIButton){
        delegate?.sortButtonTapped(self)
    }
}
