//
//  ProfileOrderView.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/19/22.
//

import UIKit

protocol ProfileOrderViewDelegate: NSObjectProtocol {
    func didTapOrder(orderID: UUID?, sender: ProfileOrderView)
}

class ProfileOrderView: UIView {

    struct Model {
        let orderID: UUID
        let text: String
    }

    var model: Model? {
        didSet {
            applyModel()
        }
    }
    weak var delegate:ProfileOrderViewDelegate?

    func applyModel() {
        textLabel?.text = model?.text
    }

    // MARK: XIB fields

    @IBOutlet var textLabel: UILabel?

    @IBAction func didTapOrderView(_ sender: UITapGestureRecognizer) {
        delegate?.didTapOrder(orderID: model?.orderID, sender: self)
    }

}
