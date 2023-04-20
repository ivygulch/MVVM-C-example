//
//  OnboardingCoordinator.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import Foundation
import UIKit

typealias OnboardingCoordinatorResult = OnboardingCoordinator.Result

class OnboardingCoordinator: Coordinator<OnboardingCoordinatorResult> {

    enum Result {
        case skipped
        case finished
    }

    let presentingViewController: UIViewController
    lazy var viewController: OnboardingViewController = UIStoryboard.load()

    private let container: Container

    init(container: Container, presentingViewController: UIViewController, onFinish: @escaping OnFinishSignature) {
        self.container = container
        self.presentingViewController = presentingViewController

        super.init(onFinish: onFinish)
    }

    override func start() {
        presentViewController()
    }

    override func finish(_ result: OnboardingCoordinatorResult) {
        presentingViewController.dismiss(animated: true)
        
        super.finish(result)
    }

    private func presentViewController() {
        viewController.model = .init(
            title: "Onboarding Title",
            titleFont: .boldSystemFont(ofSize: 32.0),
            text: "Onboarding text",
            textFont: .systemFont(ofSize: 16.0)
        )
        viewController.delegate = self
        presentingViewController.present(viewController, animated: true)
    }

    private func skipOnboarding() {
        finish(.skipped)
    }

    private func finishOnboarding() {
        finish(.finished)
    }

}

extension OnboardingCoordinator: OnboardingViewControllerDelegate {
    func didTapSkip(sender: OnboardingViewController) {
        skipOnboarding()
    }

    func didTapFinish(sender: OnboardingViewController) {
        finishOnboarding()
    }
}
