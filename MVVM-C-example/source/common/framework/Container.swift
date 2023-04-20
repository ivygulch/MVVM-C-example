//
//  Container.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import Foundation

class Container {
    static let shared = Container()

    private enum RegistryState {
        case pending((Container) -> Any)
        case resolved(Any)
    }

    private var registry: [String: RegistryState] = [:]
    private let queue = DispatchQueue(label: "com.mvvmcexample.Container.\(UUID().uuidString)")

    func register<Interface>(_ interface: Interface.Type, _ provider: @escaping (Container) -> Interface) {
        queue.sync { registry[key(interface)] = .pending(provider) }
    }

    func unregister<Interface>(_ interface: Interface.Type) {
        _ = queue.sync { registry.removeValue(forKey: key(interface)) }
    }

    func get<Interface>(_ interface: Interface.Type) -> Interface {
        let result = getIfRegistered(interface)
        assert(result != nil, "Interface for \(interface) is required")
        return result!
    }

    func getIfRegistered<Interface>(_ interface: Interface.Type) -> Interface? {
        let key = key(interface)
        let checkState = queue.sync { registry[key] }
        guard let state = checkState else { return nil }

        let result: Interface?
        switch state {
        case let .pending(provider):
            let implementation = provider(self)
            queue.sync { registry[key] = .resolved(implementation) }
            result = implementation as? Interface
        case let .resolved(implementation):
            result = implementation as? Interface
        }
        assert(result != nil, "Expected interface for: \(key)")
        return result
    }

    private func key(_ a: Any) -> String {
        "\(a)" // super simplistics approach to a common key
    }
}
