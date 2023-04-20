//
//  ProfileViewPresentation.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/18/22.
//

import Foundation

extension ProfileViewController.Model {
    init(user: User) {
        orderListViewModel = .init(orderIDs: user.orderIDs)
        titleHeaderViewModel = .init(user: user)
    }
}
