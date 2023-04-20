//
//  UserSettings.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import Foundation

protocol UserSettingsProvider {
    var viewedOnboarding: Bool { get set }
}

class UserSettingsProviding: UserSettingsProvider {
    private enum Key: String {
        case viewedOnboarding
    }

    private let userDefaults: UserDefaults
    private let userIDProvider: UserIDProvider

    init(userDefaults: UserDefaults, userIDProvider: UserIDProvider) {
        self.userDefaults = userDefaults
        self.userIDProvider = userIDProvider
    }

    private func key(_ key: Key) -> String {
        let prefix = userIDProvider.userID
        return "\(prefix)_\(key.rawValue)"
    }

    var viewedOnboarding: Bool {
        get {
            userDefaults.bool(forKey: key(.viewedOnboarding)) == true            
        }
        set {
            userDefaults.set(newValue, forKey: key(.viewedOnboarding))
            userDefaults.synchronize()
        }
    }

}
