//
//  Coordinator.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import UIKit

class Coordinator<CoordinationResult>: NSObject {
    typealias OnFinishSignature = ((CoordinationResult) -> Void)
    private(set) var childCoordinators: [UUID: Any] = [:]
    private var cleanupFromParent: (() -> Void)?

    let identifier = UUID()
    var onFinish: OnFinishSignature?

    init(onFinish: OnFinishSignature? = nil) {
        self.onFinish = onFinish
        
        super.init()
    }
    
    open func start() {
    }

    open func finish(_ result: CoordinationResult) {
        cleanupFromParent?()
        onFinish?(result)
    }

    @discardableResult
    func add<T>(child: Coordinator<T>) -> Coordinator<T> {
        child.cleanupFromParent = { [weak self, weak child] in
            self?.remove(child: child)
        }
        childCoordinators[child.identifier] = child
        return child
    }

    @discardableResult
    private func remove<T>(child: Coordinator<T>?) -> Coordinator<T>? {
        guard let child = child else { return nil }

        childCoordinators.removeValue(forKey: child.identifier)
        return child
    }
}
