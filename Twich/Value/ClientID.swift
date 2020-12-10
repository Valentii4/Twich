//
//  ClientID.swift
//  Twich
//
//  Created by Valentin Mironov on 07.12.2020.
//

import Foundation
@propertyWrapper
class Inject<ClientId> {
    private var kept: ClientId?
    
    public var wrappedValue: ClientId {
        kept ?? {
            let dependency: ClientId = ServiceLocator.resolve(service: ClientId.self, name: .clientId)!
            kept = dependency
            return dependency
        }()
    }
}
struct ClientId {
    let id: String
    init(id: String) {
        self.id = id
    }
}
