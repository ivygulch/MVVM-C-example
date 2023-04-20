//
//  ProfileStreakView.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/18/22.
//

import UIKit

protocol ProfileStreakViewDelegate: NSObjectProtocol {
}

class ProfileStreakView: UIView {

    struct Model {
    }

    var model: Model? {
        didSet {
            applyModel()
        }
    }
    weak var delegate:ProfileStreakViewDelegate?

    func applyModel() {
    }

    // MARK: XIB fields

}
