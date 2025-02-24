//
//  LottoViewController.swift
//  Lotto
//
//  Created by 이상민 on 2/24/25.
//

import UIKit
import SnapKit
import Alamofire
import RxSwift
import RxCocoa

struct Lotto: Decodable{
    let drwNoDate: String
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

class LottoViewController: UIViewController {
    
//    private var lotto: Lotto?
    
    private let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private lazy var textxField: UITextField = {
        let textField = UITextField()
        textField.inputView = pickerView
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.textAlignment = .center
        return textField
    }()
    
    private let winInformationText: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let winInformationDate: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var winInformationView: UIView = {
        let view = UIView()
        view.addSubview(winInformationText)
        view.addSubview(winInformationDate)
        
        let viewBottomBorder = UIView()
        viewBottomBorder.backgroundColor = .lightGray
        view.addSubview(viewBottomBorder)
        viewBottomBorder.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    private let winnerResultNoText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .orange
        return label
    }()
    
    private let winnerResultText: UILabel = {
        let label = UILabel()
        label.text = "당첨결과"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var winnerResultStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [winnerResultNoText, winnerResultText])
        view.spacing = 5
        view.axis = .horizontal
        return view
    }()
    
    // TODO: 넘겨 받는 데이터에 따라서 한번에 만들 수 있을 것 같다
    private lazy var oneBall = createBallLabel()
    private lazy var twoBall = createBallLabel()
    private lazy var threeBall = createBallLabel()
    private lazy var fourBall = createBallLabel()
    private lazy var fiveBall = createBallLabel()
    private lazy var sixBall = createBallLabel()
    
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "+"
        label.font = UIFont.systemFont(ofSize: 16)
        
        let spacing = 5.0
        let width = ((UIScreen.main.bounds.width - 48.0) - (spacing * 7)) / 8
        
        label.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(width)
        }
        
        return label
    }()
    
    private lazy var bonusBall = createBallLabel()
    
    private lazy var bonusView: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "보너스"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        view.addSubview(bonusBall)
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(bonusBall.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        return view
    }()
    
    private lazy var winResultStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [oneBall, twoBall, threeBall, fourBall, fiveBall, sixBall, plusLabel ,bonusView])
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fillEqually
        return view
    }()
    
    private let observableBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Observable", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .gray
        return btn
    }()
    
    private let singleBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Single", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .gray
        return btn
    }()
    
    let viewModel = LottoViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setBind()
    }
    
    func setBind(){
        let input = LottoViewModel.Input(
            pickerGesture: pickerView.rx.itemSelected,
            observabledBtnTap: observableBtn.rx.tap,
            singleBtnTap: singleBtn.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.lottoRound
            .bind(to: pickerView.rx.itemTitles){ (row, element) in
                return "\(element)회"
            }
            .disposed(by: disposeBag)
        
        output.lottoData
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                owner.insertData(data: value)
            }
            .disposed(by: disposeBag)
        
        output.selectedRound
            .map { "\($0)회" }
            .bind(to: textxField.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setUp(){
        self.view.backgroundColor = .white
        self.view.addSubview(textxField)
        self.view.addSubview(winInformationView)
        self.view.addSubview(winnerResultStackView)
        self.view.addSubview(winResultStackView)
        self.view.addSubview(observableBtn)
        self.view.addSubview(singleBtn)
        
        textxField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }
        
        winInformationView.snp.makeConstraints { make in
            make.top.equalTo(textxField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }
        
        winInformationText.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        winInformationDate.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        winnerResultStackView.snp.makeConstraints { make in
            make.top.equalTo(winInformationView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }

        winResultStackView.snp.makeConstraints { make in
            make.top.equalTo(winnerResultNoText.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        observableBtn.snp.makeConstraints { make in
            make.top.equalTo(winResultStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(24)
        }
        
        singleBtn.snp.makeConstraints { make in
            make.top.equalTo(winResultStackView.snp.bottom).offset(10)
            make.leading.equalTo(observableBtn.snp.trailing).offset(14)
        }
    }
    
    func createBallLabel() -> UILabel{
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        
        let spacing = 5.0
        let width = ((UIScreen.main.bounds.width - 48.0) - (spacing * 7)) / 8
        label.layer.cornerRadius = width / 2
        label.layer.masksToBounds = true
        
        label.snp.makeConstraints { make in
            make.size.equalTo(width)
        }
        
        return label
    }
    
    // TODO: 코드 최적화 시키기
    func insertData(data: Lotto){
        self.winInformationDate.text = "\(data.drwNoDate) 추천"
        
        self.oneBall.text = "\(data.drwtNo1)"
        self.oneBall.backgroundColor = setBallColor(number: data.drwtNo1)
        
        self.twoBall.text = "\(data.drwtNo2)"
        self.twoBall.backgroundColor = setBallColor(number: data.drwtNo2)
        
        self.threeBall.text = "\(data.drwtNo3)"
        self.threeBall.backgroundColor = setBallColor(number: data.drwtNo3)
        
        self.fourBall.text = "\(data.drwtNo4)"
        self.fourBall.backgroundColor = setBallColor(number: data.drwtNo4)
        
        self.fiveBall.text = "\(data.drwtNo5)"
        self.fiveBall.backgroundColor = setBallColor(number: data.drwtNo5)
        
        self.sixBall.text = "\(data.drwtNo6)"
        self.sixBall.backgroundColor = setBallColor(number: data.drwtNo6)
        
        self.bonusBall.text = "\(data.bnusNo)"
        self.bonusBall.backgroundColor = setBallColor(number: data.bnusNo)
    }
    
    func setBallColor(number: Int) -> UIColor{
        switch number{
        case 1...10:
            return UIColor.orange
        case 11...20:
            return UIColor.black
        case 21...30:
            return UIColor.red
        case 31...40:
            return UIColor.gray
        case 41...45:
            return UIColor.green
        default:
            return UIColor.clear
        }
    }
}
