//
//  Router.swift
//  Twich
//
//  Created by Valentin Mironov on 07.12.2020.
//

import Foundation
import Alamofire
struct Router: URLRequestConvertible {
    let request:Request

    init(request:  Request) {
        self.request = request
    }
    
    func asURLRequest() throws -> URLRequest {
        let param = request.params
        let encoding = URLEncoding.default

        return try encoding.encode(request, with: param)
    }
}


extension Router{
    struct Request: URLRequestConvertible {
        let url: URL
        let method: HTTPMethod
        var accept: String = "application/json"
        var headers: HTTPHeaders?
        var params: [String: Any]?
        @Inject private var clientId: ClientId
    
        init(url: URL, method: HTTPMethod, accept: String?) {
            self.url = url
            self.method = method
            
            if let accept = accept{
                self.accept = accept
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            var request = URLRequest(url: url)
            request.method = method
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.setValue(accept, forHTTPHeaderField: "Accept")
            request.headers.add(HTTPHeader(name: "Client-ID", value: clientId.id))
            
            return request
        }
        
    }
}
