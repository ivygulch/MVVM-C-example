//
//  ProfileTitleHeaderViewPresentation.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/18/22.
//

import Foundation

extension ProfileTitleHeaderView.Model {
    init(user: User) {
        text = "User: \(user.displayName)"
        textFont = .systemFont(ofSize: 12.0)
        settingsButtonTitle = "Settings"
    }
}
