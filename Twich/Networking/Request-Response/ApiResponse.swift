//
//  ApiResponse.swift
//  TwichTest
//
//  Created by Valentin Mironov on 18.11.2020.
//

import Foundation
protocol ApiResponse: Codable {
    init?(json: [String: Any])
}
