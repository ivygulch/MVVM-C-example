//
//  Order.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 4/20/23.
//

import Foundation

struct Order {
    let id: UUID
    let orderDate: Date
    let products: [Product]
    let itemTotal: Decimal
    let taxTotal: Decimal
    let grandTotal: Decimal
}
