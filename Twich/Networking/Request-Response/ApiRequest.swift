//
//  ApiRequest.swift
//  TwichTest
//
//  Created by Valentin Mironov on 18.11.2020.
//

import Foundation
protocol ApiRequest: Codable {
    func getArray() -> [String:Any]
}
