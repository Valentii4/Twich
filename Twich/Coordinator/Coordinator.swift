//
//  Coordinator.swift
//  Twich
//
//  Created by Valentin Mironov on 08.12.2020.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
