//
//  NetworkManager.swift
//  RxSwiftStudy3
//
//  Created by 이상민 on 2/24/25.
//

import Foundation

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
    
    func callBoxOffice(date: String, completionHandler: @escaping ((Result<Movie, APIError>) -> Void)){
        let url =  "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=1e11e012e5de56d8598e901746dc0848&targetDt=\(date)"
        
        guard let url = URL(string: url) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                completionHandler(.failure(.unknownResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else{
                completionHandler(.failure(.statusError))
                return
            }
            
            if let data = data{
                do{
                    let result = try JSONDecoder().decode(Movie.self, from: data)
                    completionHandler(.success(result))
                }catch{
                    completionHandler(.failure(.unknownResponse))
                }
            }else{
                completionHandler(.failure(.unknownResponse))
            }
        }
        .resume()
    }
}
