//
//  SettingsViewController.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/18/22.
//

import UIKit

protocol SettingsViewControllerDelegate: NSObjectProtocol {
    func didTapCloseButton(sender: SettingsViewController)
}

class SettingsViewController: UIViewController {

    struct Model {
        let title: String
        let titleFont: UIFont
    }

    var model: Model? {
        didSet {
            applyModel()
        }
    }
    weak var delegate: SettingsViewControllerDelegate?

    func applyModel() {
        loadViewIfNeeded()

        titleLabel?.text = model?.title
        titleLabel?.font = model?.titleFont
    }

    // MARK: Storyboard fields

    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var closeButton: UIButton?

    @IBAction
    func closeButtonTapped(_ sender: UIButton) {
        delegate?.didTapCloseButton(sender: self)
    }
}
