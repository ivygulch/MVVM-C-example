//
//  SettingsCoordinator.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import Foundation
import UIKit

class SettingsCoordinator: Coordinator<Void> {

    lazy var viewController: SettingsViewController = UIStoryboard.load()

    private let navigationController: UINavigationController
    private let container: Container
    private var popDelegate: NavigationControllerPopDelegate?

    init(container: Container,
         navigationController: UINavigationController,
         onFinish: OnFinishSignature? = nil) {
        self.container = container
        self.navigationController = navigationController

        super.init(onFinish: onFinish)
    }

    override func start() {
        configureViewController()
        viewController.delegate = self
        popDelegate = navigationController.pushViewController(viewController, animated: true, onBack: { [weak self] in
            self?.popAndCallFinish()
        })
    }

    private func popAndCallFinish() {
        navigationController.popViewController(animated: true)
        popDelegate = nil
        finish(())
    }

    private func configureViewController() {
        viewController.view.backgroundColor = .cyan
    }

}

extension SettingsCoordinator: SettingsViewControllerDelegate {
    func didTapCloseButton(sender: SettingsViewController) {
        popAndCallFinish()
    }
}

