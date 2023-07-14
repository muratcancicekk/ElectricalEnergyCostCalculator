//
//  DetailsViewController.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import UIKit

protocol DetailsViewControllerInterface: AnyObject {
    func configure()
}

final class DetailsViewController: UIViewController {
    /// Payment History
    @IBOutlet private weak var paymentHistoryStackView: UIStackView!
    @IBOutlet private weak var paymentHistoryTableView: UITableView!
    /// Detail
    @IBOutlet private weak var electricMeterReadingLabel: UILabel!
    @IBOutlet private weak var paymentAmountLabel: UILabel!
    
    @IBOutlet weak var saveButton: BaseButton!
    
    lazy var viewModel = DetailsViewModel(viewData: viewData ?? DetailsViewData(customerNumber: "", currentMeter: 1, usersData: [ElectricalEnergyModel(customerNumber: "", currentMeter: 0, lastMeter: 0, paymentValue: 0)]), view: self)
    var viewData: DetailsViewData?
    
    init(viewData: DetailsViewData) {
        super.init(nibName: nil, bundle: nil)
        self.viewData = viewData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}
extension DetailsViewController: DetailsViewControllerInterface {
    func configure() {
        saveButton.delegate = self
        saveButton.setupButtonUI(title: "Save",titleColor: .white,backgroundColor: .blue, cornerRadius: 12)
        electricMeterReadingLabel.text = "Electric Meter: \(viewModel.currentMeter)"
        paymentAmountLabel.text = "Payment Amount: \(viewModel.amount)"
    }
}
extension DetailsViewController: CustomButtonViewProtocol {
    func didButtonTapped(_ value: Int?) {
        viewModel.setUser()
    }
}
