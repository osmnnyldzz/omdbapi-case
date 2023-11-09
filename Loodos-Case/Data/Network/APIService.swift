//
//  APIService.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

import Alamofire

final class ApiService {
    func request<T : Codable>(_ urlConvertible: URLRequestConvertible, completion: @escaping (Result<T, Error>) -> Void){
        AF.request(urlConvertible).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
