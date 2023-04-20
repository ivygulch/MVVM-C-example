//
//  MainCoordinator.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import Foundation
import UIKit

typealias MainCoordinatorResult = Void

class MainCoordinator: Coordinator<MainCoordinatorResult> {

    let tabBarController = UITabBarController()

    private let container: Container

    init(container: Container) {
        self.container = container

        super.init()
    }

    override func start() {
        configureTabBarController()
    }

    private func configureTabBarController() {
        let browseNavigationController = UINavigationController()
        browseNavigationController.tabBarItem = .init(title: "Browse", image: UIImage(named: "browse"), tag: 1)
        let browseCoordinator = BrowseCoordinator(container: container, navigationController: browseNavigationController)

        let cartNavigationController = UINavigationController()
        cartNavigationController.tabBarItem = .init(title: "Cart", image: UIImage(named: "cart"), tag: 2)
        let cartCoordinator = CartCoordinator(container: container, navigationController: cartNavigationController)

        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = .init(title: "Profile", image: UIImage(named: "profile"), tag: 3)
        let profileCoordinator = ProfileCoordinator(container: container, navigationController: profileNavigationController)

        add(child: browseCoordinator)
        add(child: cartCoordinator)
        add(child: profileCoordinator)

        tabBarController.viewControllers = [
            browseNavigationController,
            cartNavigationController,
            profileNavigationController,
        ]

        browseCoordinator.start()
        cartCoordinator.start()
        profileCoordinator.start()
    }
    
}
