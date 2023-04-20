//
//  ProfileViewController.swift
//  MVVM-C-example
//
//  Created by Douglas Sjoquist on 12/18/22.
//

import UIKit

protocol ProfileViewControllerDelegate: NSObjectProtocol {
    func didTapOrder(orderID: UUID?, sender: ProfileViewController)
    func didTapTitleSelection(sender: ProfileViewController)
    func didTapSettingsButton(sender: ProfileViewController)
}

class ProfileViewController: UIViewController {

    struct Model {
        let orderListViewModel: ProfileOrderListView.Model
        let titleHeaderViewModel: ProfileTitleHeaderView.Model
    }

    var model: Model? {
        didSet {
            applyModel()
        }
    }

    weak var delegate:ProfileViewControllerDelegate?

    private lazy var orderListView: ProfileOrderListView = {
        let result: ProfileOrderListView = .load()
        result.delegate = self
        return result
    }()
    private lazy var titleHeaderView: ProfileTitleHeaderView = {
        let result: ProfileTitleHeaderView = .load()
        result.delegate = self
        return result
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        headerStackView?.addArrangedSubview(titleHeaderView)
        bodyStackView?.addArrangedSubview(orderListView)
    }

    func applyModel() {
        orderListView.model = model?.orderListViewModel
        titleHeaderView.model = model?.titleHeaderViewModel
    }

    // MARK: Storyboard fields

    @IBOutlet var headerStackView: UIStackView?
    @IBOutlet var bodyStackView: UIStackView?
    @IBOutlet var bodyScrollView: UIScrollView?

}

extension ProfileViewController: ProfileOrderListViewDelegate {
    func didTapOrder(orderID: UUID?, sender: ProfileOrderListView) {
        delegate?.didTapOrder(orderID: orderID, sender: self)
    }
}

extension ProfileViewController: ProfileTitleHeaderViewDelegate {
    func didTapSettingsButton(sender: ProfileTitleHeaderView) {
        delegate?.didTapSettingsButton(sender: self)
    }
}

