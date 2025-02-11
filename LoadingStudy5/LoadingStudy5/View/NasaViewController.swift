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
    
    //총 데이터의 양
    var total: Double = 0
    //현재 진행중?
    var buffer: Data?{
        didSet{
//            print("Buffer", buffer)
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100) / 100"
        }
    }
    
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
        buffer = Data()
        self.callRequest()
    }
    
    func callRequest(){
        //timeoutInterval 몇 초동안 기다리다가 응답값이 안오면 실패를 반환하게 해주는 기다리는 시간 설정
        //ex) 1분동안 기다려서 응답이 올 수 있음 but 이것은 좋은 UX가 아니다 따라서 5초 안에 응답이 없으면 그냥 실패로 나타나게 할 수 있다.
        let request = URLRequest(url: Nasa.photo, timeoutInterval: 5)
        
//        URLSession.shared.dataTask(
//            with: request,
//            completionHandler: { data, response, error in
//                print("data", data)
//                print("response", response)
//                print("error", error)
//        }).resume()
        let configuration = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: .main)
        
        configuration.dataTask(with: request).resume()
    }
}

extension NasaViewController: URLSessionDataDelegate{
    
    //MARK: - 서버에서 최초로 응답을 받는 경우에 호출
    //상태코드!
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("====1====", response)
        
        //상태코드가 성공일 때, contentLength
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode){
            
            //총 데이터의 양 얻기
            guard let contentLength = response.value(forHTTPHeaderField: "Content-Length") else { return .cancel }
            
            total = Double(contentLength)!
            
            return .allow
        }else{
            return .cancel
        }
    }
    
    //MARK: - 서버에서 데이터를 받아올 때마다 반복적으로 호출
    //실질적인 데이터!
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("====2====", data)
        buffer?.append(data)
    }

    //MARK: - 응답이 완료가 되었을 때 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        print("====3====", error)
        
        if let error = error{
            progressLabel.text = "문제가 발생했다"
        }else{
            
            //completionHandler 시점과 사실상 동일
            //buffer -> Data -> Image -> ImageView
            guard let buffer = buffer else{
                print("buffer 없음")
                return
            }
            
            let image = UIImage(data: buffer)
            nasaImageView.image = image
        }
    }
}
