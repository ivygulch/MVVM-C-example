//
//  SampleAPI.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/20/22.
//

import Foundation

protocol SampleAPIProvider {
    func getProducts() -> [Product]
}

class SampleAPIProviding: SampleAPIProvider {
    func getProducts() -> [Product] {
        return []
    }
}
