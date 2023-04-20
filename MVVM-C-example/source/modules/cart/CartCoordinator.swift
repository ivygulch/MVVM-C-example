//
//  CartCoordinator.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import Foundation
import UIKit

class CartCoordinator: Coordinator<Void> {

    let navigationController: UINavigationController
    lazy var viewController: UIViewController = {
        let result = UIViewController()
        return result
    }()

    private let container: Container

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController

        super.init()
    }

    override func start() {
        configureViewController()
    }

    private func configureViewController() {
        navigationController.pushViewController(viewController, animated: true)
        viewController.view.backgroundColor = .white
    }
    
}
