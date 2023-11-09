//
//  APIRouter.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

import Alamofire
import Foundation

/*
 URLRequestConvertible ile okunabilir, kullanışlı, test yazmaya uygun bir yapı oluşturuyoruz.
 Alamofire dokümanlarında AdvancedUsage olarak tanımlanmıştır.
 bknz: https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#urlrequestconvertible
 */

enum APIRouter: URLRequestConvertible {
    
    case fetchMovie(searchText:String)
    
    private var parameters: Parameters {
        switch self {
        case .fetchMovie(let searchText):
            return [
                "s": searchText,
                "apikey":Constants.apiKey
            ]
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .fetchMovie:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .fetchMovie:
            return "/"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path),method: method)
        urlRequest.timeoutInterval = 20.0
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }

    
}
