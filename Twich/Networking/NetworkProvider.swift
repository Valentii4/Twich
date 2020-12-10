//
//  NetworkProvider.swift
//  Twich
//
//  Created by Valentin Mironov on 07.12.2020.
//

import Foundation

protocol NetworkProvider{
    func createPayment(params: GameRequest, completionhandler: @escaping (_ response: GameResponse?) -> Void)
    
    func downloadImage(url: URL) -> Data?
}
