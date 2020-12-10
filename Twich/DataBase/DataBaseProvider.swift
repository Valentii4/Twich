//
//  DataBaseProvider.swift
//  Twich
//
//  Created by Valentin Mironov on 08.12.2020.
//

import Foundation
import UIKit
protocol DataBaseProvider {    
    func createObject(name: String, viewers: Int64, channels:Int64, image: Data?, imageURL: URL ) -> TopGame
    
    func createObject(game: GameResponseTop) -> TopGame?
    
    func getObjectsTop() -> [TopGame]?
    
    func getObject(withName: String) -> TopGame?
    
    func deleteObject(object: TopGame)

}
