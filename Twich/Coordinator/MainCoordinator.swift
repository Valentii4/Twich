//
//  MainCoordinator.swift
//  Twich
//
//  Created by Valentin Mironov on 08.12.2020.
//

import Foundation
import UIKit
class MainCoordinator: Coordinator {
    //MARK: - init
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainTableViewController.instantiate()
        vc.vm =  MainTableViewModel()
        vc.coordinator = self
        vc.title = NSLocalizedString("Stream", comment: "MainTableViewConroller, title")
        navigationController.pushViewController(vc, animated: true)
    }
}
