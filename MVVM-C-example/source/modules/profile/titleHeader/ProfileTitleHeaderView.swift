//
//  ProfileTitleHeaderView.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/18/22.
//

import UIKit

protocol ProfileTitleHeaderViewDelegate: NSObjectProtocol {
    func didTapSettingsButton(sender: ProfileTitleHeaderView)
}

class ProfileTitleHeaderView: UIView {

    struct Model {
        let text: String?
        let textFont: UIFont
        let settingsButtonTitle: String
    }

    var model: Model? {
        didSet {
            applyModel()
        }
    }
    weak var delegate:ProfileTitleHeaderViewDelegate?

    func applyModel() {
        textLabel?.text = model?.text
        textLabel?.font = model?.textFont
        settingsButton?.setTitle(model?.settingsButtonTitle, for: .normal)
    }

    // MARK: Storyboard fields

    @IBOutlet var textLabel: UILabel?
    @IBOutlet var settingsButton: UIButton?

    @IBAction
    func settingsButtonTapped(_ sender: UIButton) {
        delegate?.didTapSettingsButton(sender: self)
    }
}
