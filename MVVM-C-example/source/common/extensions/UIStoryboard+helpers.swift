//
//  UIStoryboard+helpers.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import UIKit

extension UIStoryboard {

    class func load<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        guard let result = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: name) as? T else {
            fatalError("Cannot instantiate a UIViewController from the storyboard for class \(name)")
        }
        return result
    }

}
