//
//  OnboardingViewController.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/17/22.
//

import UIKit

protocol OnboardingViewControllerDelegate: NSObjectProtocol {
    func didTapSkip(sender: OnboardingViewController)
    func didTapFinish(sender: OnboardingViewController)
}

class OnboardingViewController: UIViewController {

    struct Model {
        let title: String
        let titleFont: UIFont
        let text: String
        let textFont: UIFont
    }

    var model: Model? {
        didSet {
            applyModel()
        }
    }
    weak var delegate: OnboardingViewControllerDelegate?

    func applyModel() {
        loadViewIfNeeded()
        
        titleLabel?.text = model?.title
        titleLabel?.font = model?.titleFont
        textLabel?.text = model?.text
        textLabel?.font = model?.textFont
    }

    // MARK: Storyboard fields

    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var textLabel: UILabel?
    @IBOutlet var skipButton: UIButton?
    @IBOutlet var finishButton: UIButton?

    @IBAction
    func skipTapped(_ sender: UIButton) {
        delegate?.didTapSkip(sender: self)
    }

    @IBAction
    func finishTapped(_ sender: UIButton) {
        delegate?.didTapFinish(sender: self)
    }
}
