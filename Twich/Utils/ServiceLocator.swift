//
//  ServiceLocator.swift
//  Twich
//
//  Created by Valentin Mironov on 07.12.2020.
//

import Foundation
import Swinject

final class ServiceLocator {
    
    static let networking: NetworkProvider = AlamofireManager()
    static let dataBase: DataBaseProvider = CoreDataManager()
    
    private static let container = Container()
    
    public static func register<T>(name: Id, value: T) {
        container.register(type(of: value), name: name.rawValue) { _ in value }
    }
    
    public static func resolve<T>(service: T.Type, name: Id) -> T? {
        return container.resolve(service, name: name.rawValue)
    }
    
    enum Id: String {
        case clientId = "Client-ID"
    }
}

