//
//  StartupCoordinator.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import Foundation
import UIKit

typealias StartupCoordinatorResult = Result<StartupCoordinator.Result, Error>

class StartupCoordinator: Coordinator<StartupCoordinatorResult> {

    struct Result {
        let mainCoordinator: MainCoordinator
    }

    private let container: Container
    private let withRootViewController: ((UIViewController) -> Void)

    init(container: Container,
         withRootViewController: @escaping ((UIViewController) -> Void),
         onFinish: OnFinishSignature? = nil) {
        self.container = container
        self.withRootViewController = withRootViewController

        super.init(onFinish: onFinish)
    }

    override func start() {
        configureContainer()

        let mainCoordinator = MainCoordinator(container: container)
        withRootViewController(mainCoordinator.tabBarController)

        checkForOnboarding(mainCoordinator: mainCoordinator)
        
        finish(.success(.init(mainCoordinator: mainCoordinator)))
    }

    private func checkForOnboarding(mainCoordinator: MainCoordinator) {
        var userSettings = container.get(UserSettingsProvider.self)
        guard !userSettings.viewedOnboarding else { return }

        let onboardingCoordinator = OnboardingCoordinator(
            container: container,
            presentingViewController: mainCoordinator.tabBarController
        ) { result in
            switch result {
            case .skipped:
                userSettings.viewedOnboarding = false
            case .finished:
                userSettings.viewedOnboarding = true
            }
        }
        mainCoordinator.add(child: onboardingCoordinator)
        onboardingCoordinator.start()
    }


    private func configureContainer() {
        container.register(UserSettingsProvider.self) { container in
            struct TempUserIDProvider: UserIDProvider {
                let userID: String = "temp"
            }
            return UserSettingsProviding(
                userDefaults: .standard,
                userIDProvider: TempUserIDProvider()
            )
        }
    }

}
