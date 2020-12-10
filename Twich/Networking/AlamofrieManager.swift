//
//  AlamofrieManager.swift
//  Twich
//
//  Created by Valentin Mironov on 07.12.2020.
//

import Foundation
import Alamofire

struct AlamofireManager: NetworkProvider {
    private let url = URL(string: "https://api.twitch.tv/kraken/games/top")
    
    func createPayment(params: GameRequest, completionhandler: @escaping (GameResponse?) -> Void) {
        
        guard let url = url else{
            print("Urls for request not valide")
            return
        }
        
        
        var routerRequest = Router.Request(url: url, method: .get, accept: "application/vnd.twitchtv.v5+json")
        routerRequest.params = params.getArray()
        let request = Router(request: routerRequest)
        AF.request(request).responseJSON { (responseJSON) in
            switch responseJSON.result{
            case .success(let value):
                guard let jsonObject = value as? [String: Any] else {
                    completionhandler(nil)
                    return
                }
                completionhandler(GameResponse(json: jsonObject))
                
            case .failure(let error):
                completionhandler(nil)
                print(error)
            }
        }
    }
    
    func downloadImage(url: URL) -> Data?{
        return try? Data(contentsOf: url)
    }
    
}
