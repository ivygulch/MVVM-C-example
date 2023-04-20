//
//  ProfileOrderListView.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/18/22.
//

import UIKit

protocol ProfileOrderListViewDelegate: NSObjectProtocol {
    func didTapOrder(orderID: UUID?, sender: ProfileOrderListView)
}

class ProfileOrderListView: UIView {

    struct Model {
        let orderViewModels: [ProfileOrderView.Model]
    }

    var model: Model? {
        didSet {
            applyModel()
        }
    }
    weak var delegate: ProfileOrderListViewDelegate?

    func applyModel() {
        stackView?.removeAllSubviews()

        model?.orderViewModels.forEach {
            let ordersItemView: ProfileOrderView = .load()
            ordersItemView.model = $0
            ordersItemView.delegate = self
            stackView?.addArrangedSubview(ordersItemView)
        }
    }

    // MARK: XIB fields

    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var stackView: UIStackView?
}

extension ProfileOrderListView: ProfileOrderViewDelegate {
    func didTapOrder(orderID: UUID?, sender: ProfileOrderView) {
        delegate?.didTapOrder(orderID: orderID, sender: self)
    }
}
