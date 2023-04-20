//
//  UIView+helpers.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/18/22.
//

import UIKit

extension UIView {
    class func load<T: UIView>() -> T {
        let name = String(describing: T.self)
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: name, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Cannot instantiate a UIView from the nib for class \(name)")
        }
        return view
    }
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
}
