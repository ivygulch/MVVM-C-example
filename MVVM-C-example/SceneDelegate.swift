//
//  SceneDelegate.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let container = Container()
    lazy var rootCoordinator = RootCoordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

       let window = UIWindow(windowScene: windowScene)

        let startupCoordinator = StartupCoordinator(
            container: self.container,
            withRootViewController: { rootViewController in
                window.rootViewController = rootViewController
                window.makeKeyAndVisible()
            },
            onFinish: startupOnFinish
        )
        rootCoordinator.add(child: startupCoordinator)
        startupCoordinator.start()

        self.window = window
    }

    private func startupOnFinish(_ startupResult: StartupCoordinatorResult) {
        switch startupResult {
        case let .success(startupSuccess):
            let mainCoordinator = startupSuccess.mainCoordinator
            rootCoordinator.add(child: mainCoordinator)

            mainCoordinator.start()
        case let .failure(error):
            fatalError("Need something better than this: \(error)")
        }
    }

}

class RootCoordinator: Coordinator<Void> {
}
