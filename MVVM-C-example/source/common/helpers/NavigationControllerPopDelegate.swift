//
//  NavigationControllerPopDelegate.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/18/22.
//

import UIKit

// This is [atleast a partial] solution to controlling pop behavior with coordinators,
class NavigationControllerPopDelegate: NSObject, UINavigationControllerDelegate {
    private var navigationController: UINavigationController
    private var viewControllerToWatch: UIViewController
    private let onBack: (() -> Void)
    private var originalDelegate: UINavigationControllerDelegate?

    init(
        navigationController: UINavigationController,
        viewControllerToWatch: UIViewController,
        onBack: @escaping (() -> Void)
    ) {
        self.navigationController = navigationController
        self.viewControllerToWatch = viewControllerToWatch
        self.onBack = onBack
        self.originalDelegate = navigationController.delegate

        super.init()
        navigationController.delegate = self
    }

    deinit {
        navigationController.delegate = originalDelegate // reset just in case
    }

    // provide custom onBack method 
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC == viewControllerToWatch && operation == .pop {
            navigationController.delegate = originalDelegate
            onBack()
        }
        return nil
    }
}

extension UINavigationController {
    func pushViewController(
        _ viewController: UIViewController,
        animated: Bool,
        onBack: @escaping (() -> Void)
    ) -> NavigationControllerPopDelegate {
        let newDelegate = NavigationControllerPopDelegate(
            navigationController: self,
            viewControllerToWatch: viewController,
            onBack: onBack
        )
        pushViewController(viewController, animated: animated)
        return newDelegate
    }
}
