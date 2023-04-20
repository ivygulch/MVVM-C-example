//
//  ProfileCoordinator.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator<Void> {

    let navigationController: UINavigationController
    let viewController: ProfileViewController = UIStoryboard.load()

    private let container: Container

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController

        super.init()
    }

    override func start() {
        configureViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

    private func configureViewController() {
        viewController.model = .init(user: .mock())
    }

    private func startSettingsCoordinator() {
        let settingsCoordinator = SettingsCoordinator(container: container, navigationController: navigationController)
        add(child: settingsCoordinator)

        settingsCoordinator.viewController.model = .init(
            title: "This screen is managed by SettingsCoordinator",
            titleFont: .systemFont(ofSize: 32.0)
        )
        settingsCoordinator.start()
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        navigationController.present(alert, animated: true)
    }
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    func didTapOrder(orderID: UUID?, sender: ProfileViewController) {
        showAlert(
            title: "Action: OrdersItem",
            message: "Could start orders coordinator here with orderID=\(String(describing: orderID))"
        )
    }

    func didTapTitleSelection(sender: ProfileViewController) {
        showAlert(
            title: "Action: didTapTitleSelection",
            message: "Could start something when tapping title"
        )
    }

    func didTapSettingsButton(sender: ProfileViewController) {
        startSettingsCoordinator()
    }
}


// MARK: - temporary mock data

private extension User {
    static func mock(
        id: UUID = UUID(),
        displayName: String = "Mock User",
        orderIDs: [UUID] = [.init(), .init()]
    ) -> User {
        .init(
            id: id,
            displayName: displayName,
            orderIDs: orderIDs
        )
    }
}

private extension Product {
    static func mock(
        id: UUID = UUID(),
        description: String = "Mock Description",
        price: Decimal = 12.34
    ) -> Product {
        .init(
            id: id,
            description: description,
            price: price
        )
    }
}
