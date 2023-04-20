//
//  ProfileOrderListViewPresentation.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/18/22.
//

import Foundation

extension ProfileOrderListView.Model {
    init(orderIDs: [UUID]) {
        orderViewModels = orderIDs.map {
            .init(orderID: $0, text: "Order: \($0)")
        }
    }
}
