//
//  NetworkManager.swift
//  NaverShopping
//
//  Created by 이상민 on 2/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func callShoppingRequest(query: String) -> Single<ItemResponse>{
        
        return Single<ItemResponse>.create { value in
            let url = "https://openapi.naver.com/v1/search/shop?query=\(query)&display=100"
            
            guard let url = URL(string: url) else {
                return Disposables.create {
                    print("끝1")
                }
            }
            
            var request = URLRequest(url: url)
            
            guard let clientId = Bundle.main.infoDictionary?["NaverClientID"] as? String,
                  let clientSecret = Bundle.main.infoDictionary?["NaverClientSecretID"] as? String else {
                print("인증 실패")
                
                return Disposables.create {
                    print("끝2")
                }
            }
            
            request.addValue(clientId, forHTTPHeaderField: "X-Naver-Client-Id")
            request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    value(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else{
                    print("오잉")
                    return
                }
                
                if let data = data{
                    do{
                        let result = try JSONDecoder().decode(ItemResponse.self, from: data)
                        value(.success(result))
                    }catch{
                        value(.failure(error))
                    }
                }else{
                    print("이것도 끝")
                }
            }
            .resume()
            
            return Disposables.create {
                print("끝3")
            }
        }
    }
}
