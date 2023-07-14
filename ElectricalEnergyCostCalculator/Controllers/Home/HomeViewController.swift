//
//  HomeViewController.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import UIKit
import Combine

protocol HomeViewInterface: AnyObject, SeguePerformable {
    func configureView()
    func bind()
    func pushVC(viewData: DetailsViewData)
}

final class HomeViewController: UIViewController {
    /// Customer Number
    @IBOutlet private weak var customerNumberLabel: UILabel!
    @IBOutlet private weak var customerNumberTextField: BaseTextField!
    /// Current Meter
    @IBOutlet private weak var currentMeterLabel: UILabel!
    @IBOutlet private weak var currentMeterTextField: BaseTextField!
    /// SubmitButton
    @IBOutlet private weak var submitButton: BaseButton!
    
    private lazy var viewModel = HomeViewModel(view: self)
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        bind()
    }
}
extension HomeViewController: HomeViewInterface {
    func pushVC(viewData: DetailsViewData ) {
        let detailsVC = DetailsViewController(viewData: viewData)
        detailsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func bind() {
        customerNumberTextField.$fieldValue.assign(to: &viewModel.$customerNumber)
        currentMeterTextField.$fieldValue.assign(to: &viewModel.$currentMeter)
        
        viewModel.$isReady.sink {  value in
            self.submitButton.setupButtonUI(title: Constants.shared.globalSubmit, backgroundColor: value ? .blue.withAlphaComponent(0.6) : .gray.withAlphaComponent(0.6) , cornerRadius: 12)
        }.store(in: &cancellables)
        
    }
    
    func configureView() {
        submitButton.delegate = self
        submitButton.setupButtonUI(title: Constants.shared.globalSubmit, backgroundColor: .gray.withAlphaComponent(0.6), cornerRadius: 12)
        /// Customer Number Configure
        customerNumberLabel.configure(text: Constants.shared.customerNumber, font: .systemFont(ofSize: 16), textColor: .black, numberOfLines: 1)
        customerNumberTextField.setupTextfieldUI(cornerRadius: 12, placeHolder: Constants.shared.customerNumberPlaceHolder, textFiedldTypeChoose: .alphaNumerics)
        /// Customer Meter Configure
        currentMeterLabel.configure(text: Constants.shared.currentMeter, font: .systemFont(ofSize: 16), textColor: .black, numberOfLines: 1)
        customerNumberTextField.setupTextfieldUI(cornerRadius: 12, placeHolder: Constants.shared.currentMeterPlaceHolder, textFiedldTypeChoose: .number)
    }
}
extension HomeViewController: CustomButtonViewProtocol {
    func didButtonTapped(_ value: Int?) {
        if Helpers.shared.checkMeter(viewModel.currentMeter) == true && Helpers.shared.validateString(viewModel.customerNumber) == true {
            pushVC(viewData: DetailsViewData(customerNumber: viewModel.customerNumber, currentMeter: Int(viewModel.currentMeter) ?? 0, usersData: viewModel.usersData ?? [ElectricalEnergyModel(customerNumber: viewModel.customerNumber, currentMeter: Int(viewModel.currentMeter) ?? 0, lastMeter: 0, paymentValue: 0)]))
        }
    }
}
