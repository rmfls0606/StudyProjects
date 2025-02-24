//
//  NetworkManager.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/24/25.
//

import Foundation
import RxSwift
import RxCocoa

enum APIError: Error{
    case invalidURL
    case unknownResponse
    case statusError
}

/*
 completionHandler (Model?)
 completionHandler (Model?, Error?)
 */
final class NetworkManager{
    static let shared = NetworkManager()
    
    private init() { }
//    func callBoxOffice(date: String) -> Observable<Movie>{
//        
//        return Observable<Movie>.create { value in
//            
//            let url =  "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=1e11e012e5de56d8598e901746dc0848&targetDt=\(date)"
//            
//            guard let url = URL(string: url) else {
//                value.onError(APIError.invalidURL)
//                return Disposables.create {
//                    print("끝")
//                }
//            }
//            
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error = error{
//                    value.onError(APIError.unknownResponse)
//                    return
//                }
//                
//                guard let response = response as? HTTPURLResponse,
//                      (200...299).contains(response.statusCode) else{
//                    value.onError(APIError.statusError)
//                    return
//                }
//                
//                if let data = data{
//                    do{
//                        let result = try JSONDecoder().decode(Movie.self, from: data)
//                        value.onNext(result)
//                        value.onCompleted()//원하는 데이터 전달 시 종료 필요!!(중요!!!)
//                    }catch{
//                        value.onError(APIError.unknownResponse)
//                    }
//                }else{
//                    value.onError(APIError.unknownResponse)
//                }
//            }
//            .resume()
//            
//            return Disposables.create {
//                print("끝")
//            }
//        }
//    }
    func callBoxOfficeWithSingle(date: String) -> Single<Movie>{
        //single:  next가 끝나면 자동으로 completed해주는 기능

        return Single<Movie>.create { value in
            
            let url =  "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=1e11e012e5de56d8598e901746dc0848&targetDt=\(date)"
            
            guard let url = URL(string: url) else {
                value(.failure(APIError.invalidURL))
                return Disposables.create {
                    print("끝")
                }
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error{
                    value(.failure(APIError.unknownResponse))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else{
                    value(.failure(APIError.statusError))
                    return
                }
                
                if let data = data{
                    do{
                        let result = try JSONDecoder().decode(Movie.self, from: data)
                        value(.success(result))
                    }catch{
                        value(.failure(APIError.unknownResponse))
                    }
                }else{
                    value(.failure(APIError.unknownResponse))
                }
            }
            .resume()
            
            return Disposables.create {
                print("끝")
            }
        }
    }
}
